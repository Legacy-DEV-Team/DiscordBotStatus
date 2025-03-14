const { Client, Collection, Intents } = require("discord.js");
const cheerio = require("cheerio");
const fetch = require("node-fetch");
const fs = require("fs");
const config = require("./config");

const client = new Client({ intents: [Intents.FLAGS.GUILDS] });

function log(message) {
  const timestamp = new Date().toISOString();
  const msg = `[${timestamp}] ${message}\n`;
  console.log(msg);
  fs.appendFileSync("./logs/index.log", msg);
}

async function getData() {
  log("[INFO] Fetching data from API...");
  const response = await fetch(config.link);
  const html = await response.text();
  const $ = cheerio.load(html);
  const codeContent = $("code").text();
  const jsonData = JSON.parse(codeContent);

  const filteredData = Object.fromEntries(
    Object.entries(jsonData?.LegacyHosting).filter(
      ([key]) => key !== "SHORTNAME"
    )
  );

  return filteredData;
}

async function updateDiscordCategories() {
  log("[INFO] Starting category update process...");
  const Servers = await getData();
  const categories = new Collection();

  for (const server in Servers) {
    const category = client.channels.cache.get(Servers[server].DISCORD_CAT);
    if (category) {
      log(`[INFO] Found category: ${category.name} (${category.id})`);
      categories.set(category.id, []);
    } else {
      log(`[WARNING] Category not found for server: ${server}`);
    }
  }

  for (const [id] of categories) {
    for (const server in Servers) {
      if (Servers[server].DISCORD_CAT == id) {
        const channel = client.channels.cache.get(Servers[server].DISCORD_ID);
        if (channel) {
          log(`[INFO] Found channel: ${channel.name} (${channel.id})`);
          categories
            .get(id)
            .push([
              channel.id,
              Servers[server].ACTIVITY,
              Servers[server].MAINTAINANCE,
            ]);
        } else {
          log(
            `[WARNING] Channel not found for server: ${server}, DISCORD_ID: ${Servers[server].DISCORD_ID}`
          );
        }
      }
    }
  }

  for (const [id, array] of categories) {
    const activities = array.map((a) => a[1]);
    const maintainances = array.map((a) => a[2]);
    let categoryStatus = "🟢";

    if (maintainances.includes("1")) {
      categoryStatus = "🟡";
    } else if (activities.includes("0")) {
      categoryStatus = activities.includes("1") ? "🟡" : "🔴";
    }

    const category = client.channels.cache.get(id);
    if (category) {
      const name = `[${categoryStatus}]${category.name.slice(4)}`;
      log(`[INFO] Updating category "${category.name}" to "${name}"`);
      if (category.name !== name) {
        await category
          .setName(name)
          .catch((err) =>
            log(`[ERROR] Failed to update category name: ${err}`)
          );
      }
    }

    for (const [channel_id, activity, maintenance] of array) {
      let emoji = activity == "1" ? "🟢" : "🔴";
      if (maintenance == "1") emoji = "🟡";

      const channel = client.channels.cache.get(channel_id);
      if (channel) {
        const channelName = `[${emoji}]${channel.name.slice(4)}`;
        log(`[INFO] Updating channel "${channel.name}" to "${channelName}"`);
        if (channel.name !== channelName) {
          await channel
            .setName(channelName)
            .catch((err) =>
              log(`[ERROR] Failed to update channel name: ${err}`)
            );
        }
      } else {
        log(`[WARNING] Channel not found: ${channel_id} for category: ${id}`);
      }
    }
  }
}

client.once("ready", async () => {
  console.log(`[INFO] Logged in as ${client.user.tag}`);
  console.log("[INFO] Initializing category update...");
  await updateDiscordCategories();

  setInterval(async () => {
    log("[INFO] Running periodic category update...");
    await updateDiscordCategories();
  }, 310_000);
});

client.login(config.token);