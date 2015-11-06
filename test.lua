discord = require 'discord.init'

testClient = discord.client.ClientObject:new()

c = testClient:login('ruairidhcarmichael@live.co.uk', 'passwordhere')

if c then print('Logged in!') end

if testClient.isLoggedIn then s = testClient:logout() end

if s then print('Logged out!') end