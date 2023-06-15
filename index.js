const axios = require('axios')
const Discord = require('discord.js')
const config = require('./config')
const client = new Discord.Client()
client.on('ready', () => func())
async function func() {
    console.log(`This confirms that I'm editing channels at ${new Date().toLocaleTimeString()}`)
    const categories = new Discord.Collection()
    const { data } = await axios(config.link)
    const [_, elementToSplit] = data.split('<code>');
    const { Servers } = JSON.parse(elementToSplit.split('<script>')[0]);
    for (const server in Servers) {
        // Instantiate categories in Collection
        const category = client.channels.cache.get(Servers[server].discord_cat)
        if (category) categories.set(category.id, [])
    }
    for (const [id] of categories) for (const server in Servers) if (Servers[server].discord_cat == id) {
        const channel = client.channels.cache.get(Servers[server].discord_id)
        if (channel) categories.get(id).push([channel.id, Servers[server].activity])
    }

    // Actual code that handles the stuff
    for (const [id, array] of categories) {
        // Get category status
        const activities = array.map(a => a[1])
        let categoryStatus = '🟢'
        if (activities.includes('0')) {
            if (activities.includes('1')) categoryStatus = '🟡'
            else categoryStatus = '🔴'
        }
        // Get category name
        const category = client.channels.cache.get(id)
        const name = `[${categoryStatus}]${category.name.slice(4)}`
        // Set category name
        if (category.name !== name) category.setName(name).catch(() => console.log(`I do not have permissions to edit channels.`))

        for (const [channel_id, activity] of array) {
            // Get channel status
            const emoji = activity == '1' ? '🟢' : '🔴'
            // Get channel name
            const channel = client.channels.cache.get(channel_id)
            const name = `[${emoji}]${channel.name.slice(4)}`
            // Set channel name
            if (channel.name !== name) channel.setName(name).catch(() => console.log(`I do not have permissions to edit channels.`))
        }
    }
    setTimeout(() => func(), 310000)
}
client.login(config.token)
