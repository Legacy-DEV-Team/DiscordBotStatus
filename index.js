import { ChannelType, Client, GatewayIntentBits } from "discord.js";
import fs from "node:fs";
import config from "./config.js";

const LOG_DIR = "./logs";
const LOG_FILE = `${LOG_DIR}/index.log`;
const UPDATE_INTERVAL_MS = 300_000;
const STATUS_PREFIX_REGEX = /^\[[^\]]+\]\s*/;
const client = new Client({ intents: [GatewayIntentBits.Guilds] });

function log(message) {
  const timestamp = new Date().toISOString();
  const msg = `[${timestamp}] ${message}\n`;
  if (!fs.existsSync(LOG_DIR)) {
    fs.mkdirSync(LOG_DIR, { recursive: true });
  }

  process.stdout.write(msg);
  fs.appendFileSync(LOG_FILE, msg);
}

function isNonEmptyString(value) {
  return typeof value === "string" && value.trim().length > 0;
}

function stripStatusPrefix(name) {
  return name.replace(STATUS_PREFIX_REGEX, "").trim();
}

function getCategoryStatusIcon(statusIcons) {
  const uniqueIcons = new Set(statusIcons.filter(isNonEmptyString));

  if (uniqueIcons.has("🟡")) {
    return "🟡";
  }

  if (uniqueIcons.has("🟢") && uniqueIcons.has("🔴")) {
    return "🟡";
  }

  if (uniqueIcons.has("🟢")) {
    return "🟢";
  }

  return "🔴";
}

async function getGuildById(guildId) {
  try {
    return await client.guilds.fetch(guildId);
  } catch (error) {
    log(`[WARNING] Failed to fetch guild ${guildId}: ${error}`);
    return null;
  }
}

async function getGuildChannel(guild, channelId) {
  try {
    return await guild.channels.fetch(channelId);
  } catch (error) {
    log(
      `[WARNING] Failed to fetch channel ${channelId} from guild ${guild.id}: ${error}`
    );
    return null;
  }
}

async function getData() {
  log("[INFO] Fetching data from API...");
  const response = await fetch(config.link);
  if (!response.ok) {
    throw new Error(`API request failed with ${response.status} ${response.statusText}`);
  }

  const jsonData = await response.json();
  if (!Array.isArray(jsonData?.servers)) {
    throw new Error("Response JSON does not contain a servers array");
  }

  return jsonData.servers.filter(
    (server) =>
      isNonEmptyString(server?.discord_server_id) &&
      isNonEmptyString(server?.discord_category_id) &&
      isNonEmptyString(server?.discord_channel_id) &&
      isNonEmptyString(server?.suggested_channel)
  );
}

async function syncDiscordNames() {
  log("[INFO] Starting Discord name sync...");
  const servers = await getData();
  const categoryTargets = new Map();
  const guildCache = new Map();

  for (const server of servers) {
    const {
      id,
      discord_server_id: guildId,
      discord_category_id: categoryId,
      discord_channel_id: channelId,
      discord_category: discordCategory,
      suggested_channel: suggestedChannel,
      status_icon: statusIcon,
    } = server;

    let guild = guildCache.get(guildId);
    if (!guild) {
      guild = await getGuildById(guildId);
      if (guild) {
        guildCache.set(guildId, guild);
      }
    }

    if (!guild) {
      log(`[WARNING] Skipping server row ${id}: guild ${guildId} was not found`);
      continue;
    }

    const categoryKey = `${guildId}:${categoryId}`;
    if (!categoryTargets.has(categoryKey)) {
      categoryTargets.set(categoryKey, {
        guild,
        categoryId,
        categoryName:
          (isNonEmptyString(discordCategory) && discordCategory.trim()) ||
          stripStatusPrefix(server.suggested_category ?? ""),
        statusIcons: [],
      });
    }

    categoryTargets.get(categoryKey).statusIcons.push(statusIcon);

    const channel = await getGuildChannel(guild, channelId);
    if (!channel) {
      log(`[WARNING] Skipping server row ${id}: channel ${channelId} was not found`);
      continue;
    }

    if (channel.name !== suggestedChannel) {
      log(
        `[INFO] Updating channel "${channel.name}" (${channel.id}) to "${suggestedChannel}"`
      );
      await channel.setName(suggestedChannel).catch((error) => {
        log(`[ERROR] Failed to update channel name ${channel.id}: ${error}`);
      });
    }
  }

  for (const {
    guild,
    categoryId,
    categoryName,
    statusIcons,
  } of categoryTargets.values()) {
    const category = await getGuildChannel(guild, categoryId);
    if (!category) {
      continue;
    }

    if (category.type !== ChannelType.GuildCategory) {
      log(
        `[WARNING] Category target ${categoryId} in guild ${guild.id} is not a category channel`
      );
      continue;
    }

    const suggestedCategory = `[${getCategoryStatusIcon(statusIcons)}] ${categoryName}`;
    if (category.name !== suggestedCategory) {
      log(
        `[INFO] Updating category "${category.name}" (${category.id}) to "${suggestedCategory}"`
      );
      await category.setName(suggestedCategory).catch((error) => {
        log(`[ERROR] Failed to update category name ${category.id}: ${error}`);
      });
    }
  }
}

client.once("clientReady", async () => {
  log(`[INFO] Logged in as ${client.user.tag}`);
  log("[INFO] Initializing Discord name sync...");
  await syncDiscordNames().catch((error) => {
    log(`[ERROR] Initial sync failed: ${error.stack ?? error}`);
  });

  setInterval(async () => {
    log("[INFO] Running periodic Discord name sync...");
    await syncDiscordNames().catch((error) => {
      log(`[ERROR] Periodic sync failed: ${error.stack ?? error}`);
    });
  }, UPDATE_INTERVAL_MS);
});

process.on("unhandledRejection", (error) => {
  log(`[ERROR] Unhandled promise rejection: ${error.stack ?? error}`);
});

process.on("uncaughtException", (error) => {
  log(`[ERROR] Uncaught exception: ${error.stack ?? error}`);
});

client.login(config.token);
