## Discord Bot Status

This project is a Discord bot that fetches data from an external API and updates the status of Discord categories and channels based on server activity and maintenance. It uses `discord.js` to interact with Discord and `cheerio` to parse HTML data from the API.

## Features

- Fetches data from a configurable API.
- Updates Discord categories and channels based on server status.
- Periodic updates every 5 minutes.
- Logs all activities to a local file for monitoring purposes.

## Installation

### Prerequisites
- Node.js (version 12 or higher)
- A Discord bot token (from the Discord Developer Portal)
- A JSON link to fetch server data

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Legacy-DEV-Team/DiscordBotStatus.git
   cd Discord-Bot-Status
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Configure the bot:
   - Open the `config.json` file and insert your bot token and the JSON link.
   ```json
   {
     "token": "YOUR_DISCORD_BOT_TOKEN",
     "link": "YOUR_JSON_API_LINK"
   }
   ```

4. Run the bot:
   ```bash
   node index.js
   ```

The bot will log in, fetch data from the API, and update the Discord categories and channels accordingly.

## Logging

All logs are stored in the `logs/index.log` file for tracking and debugging purposes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [discord.js](https://discord.js.org/) - The library used for interacting with the Discord API.
- [cheerio](https://cheerio.js.org/) - The library used for parsing HTML data.