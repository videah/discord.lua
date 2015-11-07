<p align="center">
	<img src="http://i.imgur.com/3rJienQ.png">
</p>

LuaJIT API Wrapper for Discord

Allows you to easily write bots and other things for [Discord](https://discordapp.com/) in LuaJIT.

This is a Work in Progress, and is by no means finished/usable. There is currently no docs.

```lua
discord = require 'discord.init'

myClient = discord.Client:new()

if myClient:login('email', 'password') then

	print('Logged in!')

	local serverList = myClient:getServerList()
	print('First Server Name: ' .. serverList[1].name)

	-- Server Name: Y[e]

	local channelList = myClient:getChannelList(serverList[1].id)
	print('First Channel Name: ' .. channelList[1].name)

	-- First Channel Name: general

	myClient:sendMessage('I can send messages!', channelList[1].id)

	-- # general: VideahBot: I can send messages!

end
```

# FAQ

##### Can I use this for Lua (Insert version other than LuaJIT here)?
 
 At the moment, no because **discord.lua** uses [luajit-request](https://github.com/LPGhatguy/luajit-request) to communicate with Discord's API. This could possibly be changed to LuaSockets + LuaSec, but I currently don't have the time to do that. If you feel like doing it yourself, replace the functionality inside `wrapper.lua` with whatever other lib you want.
 
##### Help, discord.lua isn't working, but was working before!

The Discord API isn't finalized yet, if something gets changed, I have to change it too. 

Come back later after I fix it, and make sure you're always on the latest version of **discord.lua**
 
# Dependencies
 * [libcurl](http://curl.haxx.se/download.html)
 * [lua-websockets](https://github.com/lipp/lua-websockets)
