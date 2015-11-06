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

local request = require(path .. 'wrapper')

local class = require(path .. 'class')
local json = require(path .. 'json')
local endpoints = require(path .. 'endpoints')
local utils = require(path .. 'utils')

print('Loaded client')

local Client = class('ClientObject')

function Client:initialize(options)

	self.isLoggedIn = false
	self.options = options
	self.token = ''
	self.email = ''

	self.headers = {
		authorization = self.token
	}

end

function Client:login(email, password)

	local payload = {
		email = email,
		password = password
	}

	local response = request.send(endpoints.login, 'POST', payload)

	if utils.responseIsSuccessful(response) then

		self.token = json.decode(response.body).token
		self.isLoggedIn = true
		self.headers.authorization = self.token
		self.email = email

		return true

	else
		return false
	end

end

function Client:logout()

	if self.isLoggedIn then

		local payload = {
			token = self.token
		}

		local response = request.send(endpoints.login, 'POST', payload)

		if utils.responseIsSuccessful(response) then

			self.isLoggedIn = false

			return true

		else
			return false
		end

	else
		return false
	end

end

function Client:getGateway()

	local response = request.send(endpoints.gateway, 'GET', nil, self.headers)

	if utils.responseIsSuccessful(response) then
		return json.decode(response.body).url
	else
		return nil
	end

end

return Client