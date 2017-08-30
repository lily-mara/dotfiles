local util = require('util')

local log = hs.logger.new('proxy', 'debug')

local function restartSquidCallback(exitCode, stdout, stderr)
	if exitCode == 0 then
		hs.notify.show('Proxy', 'Restarted squid server', '')
	else
		hs.notify.show('Proxy', 'Failed to restart squid', '')
	end
end

local function squidOutputStreamCallback(task, stdout, stderr)
	out = util.strip(stdout)
	err = util.strip(stderr)
	if string.len(out) > 0 then
		log.i(out)
	end

	if string.len(err) > 0 then
		log.e(err)
	end

	return true
end

function restartSquid()
	hs.notify.show('Proxy', 'Restarting squid server', '')
	task = hs.task.new(
		'/usr/local/bin/brew',
		restartSquidCallback,
		squidOutputStreamCallback,
		{ 'services', 'restart', 'squid' }
	)
	task:start()
end

function setLocationForSSID()
	config = hs.network.configuration.open()
	ssid = hs.wifi.currentNetwork()

	if ssid == "wireless1" then
		config:setLocation('Office')
		restartSquid()
	else
		config:setLocation('Home')
	end
end

hs.wifi.watcher.new(function(_, _, _)
	setLocationForSSID()
end):start()

hs.hotkey.bind({'cmd','alt','shift'}, 'U', restartSquid)
