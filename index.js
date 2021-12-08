const axios = require('axios')
const Discord = require('discord.js')
const config = require('./config')
const client = new Discord.Client()
client.on('ready', () => func())
async function func() {
    console.log(`This confirms that I'm editing channels at ${new Date().toLocaleTimeString()}`)
    const categories = new Discord.Collection()
    const { data: { Servers } } = await axios.get(config.link)
    for (const server in Servers) {
        // Instantiate categories in Collection
        const category = client.channels.cache.get(Servers[server].discord_cat)
        if (category) categories.set(category.id, [])
        //categories.set(Servers[server].discord_cat, [])
    }
    for (const [id] of categories) for (const server in Servers) if (Servers[server].discord_cat == id) {
        const channel = client.channels.cache.get(Servers[server].discord_id)
        if (channel) categories.get(id).push([channel.id, { activity:  Servers[server].activity, maintainance: Servers[server].maintainance }])
        //categories.get(id).push([Servers[server].discord_id, { activity:  Servers[server].activity, maintainance: Servers[server].maintainance }])
    }

    // Actual code that handles the stuff
    for (const [id, array] of categories) {
        // Get category status
        const activities = array.map(a => a[1])
        let categoryStatus = '🟢'
        if (activities.some(a => a.activity == '0')) {
            if (activities.some(a => a.activity == '1')) categoryStatus = '🟡'
            else categoryStatus = '🔴'
        }

        for (const activity of activities) {
            if (activity.maintainance == '1') categoryStatus = '🟡'
        }
        // Get category name
        const category = client.channels.cache.get(id)
        const name = `[${categoryStatus}]${category.name.slice(4)}`
        // Set category name
        if (category.name !== name) category.setName(name).catch(() => console.log(`I do not have permissions to edit channels.`))

        for (const [channel_id, activity] of array) {
            //console.log(activity)
            // Get channel status
            let emoji = activity.activity == '1' ? '🟢' : '🔴'
            if (activity.maintainance == '1') emoji = '🟡'
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