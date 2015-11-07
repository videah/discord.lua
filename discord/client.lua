-- This code is licensed under the MIT Open Source License.

-- Copyright (c) 2015 Ruairidh Carmichael - ruairidhcarmichael@live.co.uk

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

local path = (...):match('(.-)[^%.]+$') .. '.'

local ev = require 'ev'

local request = require(path .. 'wrapper')

local class = require(path .. 'class')
local json = require(path .. 'json')
local endpoints = require(path .. 'endpoints')
local util = require(path .. 'utils')

print('Loaded client')

local Client = class('ClientObject')

function Client:initialize(options)

	self.isLoggedIn = false
	self.options = options
	self.token = ''
	self.email = ''
	self.user = {}

	self.headers = {}

	self.headers['authorization'] = self.token
	self.headers['Content-Type'] = 'application/json'

	self.callbacks = {}

	self.socket = require('websocket.client').ev()

end

function Client:login(email, password)

	local payload = {
		email = email,
		password = password
	}

	local response = request.send(endpoints.login, 'POST', payload, self.headers)
	local success = util.responseIsSuccessful(response)

	if success then

		self.token = json.decode(response.body).token
		self.isLoggedIn = true
		self.headers['authorization'] = self.token
		self.email = email

		self.user = self:getCurrentUser()

	end

	return success

end

function Client:logout()

	if self.isLoggedIn then

		local payload = {
			token = self.token
		}

		local response = request.send(endpoints.login, 'POST', payload)
		local success = util.responseIsSuccessful(response)

		if success then
			self.isLoggedIn = false
		end

		return success

	else
		return false
	end

end

function Client:getGateway()

	if self.isLoggedIn then

		local response = request.send(endpoints.gateway, 'GET', nil, self.headers)

		if util.responseIsSuccessful(response) then
			return json.decode(response.body).url
		else
			return nil
		end

	end

end

function Client:getCurrentUser()

	if self.isLoggedIn then

		local response = request.send(endpoints.users .. '/@me', 'GET', nil, self.headers)

		if util.responseIsSuccessful(response) then
			return json.decode(response.body)
		else
			return nil
		end

	else
		return nil
	end

end

function Client:getServerList()

	if self.isLoggedIn then

		local response = request.send(endpoints.users .. '/' .. self.user.id .. '/guilds', 'GET', nil, self.headers)

		if util.responseIsSuccessful(response) then
			self.user = json.decode(response.body)
			return json.decode(response.body)
		else
			return nil
		end

	else
		return nil
	end

end

function Client:getChannelList(id)

	if self.isLoggedIn then

		local response = request.send(endpoints.servers .. '/' .. id .. '/channels', 'GET', nil, self.headers)

		if util.responseIsSuccessful(response) then
			return json.decode(response.body)
		else
			return nil
		end

	else
		return nil
	end

end


function Client:sendMessage(message, id)

	if self.isLoggedIn then

		local payload = { content = tostring(message) }

		local response = request.send(endpoints.channels .. '/' .. id .. '/messages', 'POST', payload, self.headers)

		return util.responseIsSuccessful(response)

	else
		return false
	end

end

function Client:run()

	if self.isLoggedIn then

		while true do
			
			if self.callbacks.think then self.callbacks.think() end

		end

	end

end

return Client