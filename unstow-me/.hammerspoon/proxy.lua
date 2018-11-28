local util = require('util')
local AnyBar = require('anybar')

local proxy = {}

local log = hs.logger.new('proxy', 'debug')
proxy.anyBarConnection = AnyBar:new(6438)

local last_ssid = nil

local function restartSquidCallback(exitCode, stdout, stderr)
	if exitCode == 0 then
		proxy.anyBarConnection:setColor('green')
	else
		proxy.anyBarConnection:setColor('exclamation')
	end
end

function proxy.restartSquid()
	proxy.anyBarConnection:setColor('orange')
	task = hs.task.new(
		'/usr/local/bin/brew',
		restartSquidCallback,
		util.buildOutputStreamLogger(log),
		{ 'services', 'restart', 'squid' }
	)
	task:start()
end

function proxy.setLocationForSSID(ssid)
	config = hs.network.configuration.open()

	if ssid == "wireless1" then
		config:setLocation('Office')
		proxy.restartSquid()
	else
		config:setLocation('Home')
		proxy.anyBarConnection:setColor('white')
	end
end

function proxy.setLocationForSSIDIfDifferent()
	ssid = hs.wifi.currentNetwork()
	if ssid ~= last_ssid then
		last_ssid = ssid
		proxy.setLocationForSSID(ssid)
	end
end

hs.wifi.watcher.new(function(_, _, _)
	proxy.setLocationForSSIDIfDifferent()
end):start()

hs.caffeinate.watcher.new(function(event)
	if event == hs.caffeinate.watcher.screensDidUnlock then
		proxy.setLocationForSSIDIfDifferent()
	end
end):start()

proxy.setLocationForSSIDIfDifferent()

return proxy
