# Discord Bot Status

A Discord bot that reads status data from a JSON endpoint and updates channel and category names across multiple Discord servers.

## What It Does

- Reads a `servers` array from your website/API
- Updates Discord channels using `suggested_channel`
- Updates Discord categories based on grouped server `status_icon` values
- Supports multiple guilds by using `discord_server_id`
- Runs every 5 minutes to avoid unnecessary rate-limit pressure
- Writes activity and errors to `logs/index.log`

## Naming Format

Channel and category names use this format:

```text
[🔴] Channel Name
[🟡] Category Name
[🟢] Server Name
```

## Category Status Rules

The bot uses `status_icon` as the source of truth for server color.

- A category becomes `🟡` if any server in that category is `🟡`
- A category becomes `🟡` if the category contains both `🟢` and `🔴` servers
- A category becomes `🟢` if all tracked servers in it are green
- A category becomes `🔴` if all tracked servers in it are red

Channel names are updated directly from `suggested_channel`.

## Required API Format

The endpoint in `config.js` must return JSON with a top-level `servers` array.

Example:

```json
{
  "source": "Server Checker",
  "servers": [
    {
      "discord_server_id": "1060670756591259709",
      "discord_category_id": "1060726992028315749",
      "discord_channel_id": "1060729008993603595",
      "discord_category": "Minecraft",
      "suggested_category": "[🟢] Minecraft",
      "suggested_channel": "[🟢] LG Craft",
      "status_icon": "🟢"
    }
  ]
}
```

## Fields the Bot Uses

- `discord_server_id`: which Discord server/guild to update
- `discord_category_id`: which category to update
- `discord_channel_id`: which channel to update
- `discord_category`: base category name used when rebuilding the category label
- `suggested_channel`: final channel name to apply
- `status_icon`: server color used when computing category color

`suggested_category` may exist in the payload, but the bot currently computes the final category name itself so mixed states work correctly.

## Setup

1. Install dependencies:

```bash
npm install
```

2. Configure [config.js](./config.js):

```js
export default {
  token: "YOUR_DISCORD_BOT_TOKEN",
  link: "https://your-site.example/status.json"
};
```

3. Start the bot:

```bash
node index.js
```

## Requirements

- Node.js 18+
- A Discord bot with permission to manage channels
- A JSON endpoint that returns the required fields

## Logging

The bot writes logs to:

```text
logs/index.log
```

This includes startup events, rename operations, skipped records, and API/Discord errors.

## Notes

- The bot only needs the `Guilds` intent
- The sync interval is 5 minutes (`300000` ms)
- It fetches guilds and channels by ID, so it can work across multiple Discord servers

## License

MIT. See [LICENSE](./LICENSE).
