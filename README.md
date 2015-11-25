<p align="center">
	<img src="http://i.imgur.com/3rJienQ.png">
</p>

LuaJIT API Wrapper for Discord

Allows you to easily write bots and other things for [Discord](https://discordapp.com/) in LuaJIT.

This is a Work in Progress, and is by no means finished/usable. There is some documentation, but it's still not recommended to use this until it's in a more complete state.

```lua
discord = require 'discord.init'

myClient = discord.Client:new()

-- For the love of god, don't store the password in a GitHub repo.
if myClient:login('email', 'password') then

	print('Logged in!')

	local serverList = myClient:getServerList()
	print('First Server Name: ' .. serverList[1].name)

	-- First Server Name: Y[e]

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

# License

This code is licensed under the MIT Open Source License.

Copyright (c) 2015 Ruairidh Carmichael - ruairidhcarmichael@live.co.uk

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
