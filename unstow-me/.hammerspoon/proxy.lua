local log = hs.logger.new('proxy', 'debug')

local function restartSquidCallback(exitCode, stdout, stderr)
	if exitCode == 0 then
		hs.notify.show('Proxy', 'Restarted squid server', '')
	else
		hs.notify.show('Proxy', 'Failed to restart squid', '')
	end
end

local function nopReturnsFalse(_, _, _)
	return false
end

function restartSquid()
	hs.notify.show('Proxy', 'Restarting squid server', '')
	task = hs.task.new(
		'/usr/local/bin/brew',
		restartSquidCallback,
		nopReturnsFalse,
		{ 'services', 'restart', 'squid' }
	)
	task:start()
end

function setLocationForSSID()
	config = hs.network.configuration.open()
	ssid = hs.wifi.currentNetwork()

	if ssid == "wireless1" then
		config:setLocation('Office')
		hs.notify.show('Network', 'Configured for office proxy', '')
		restartSquid()
	else
		config:setLocation('Home')
		hs.notify.show('Network', 'Configured for non-proxy', '')
	end
end

hs.wifi.watcher.new(function(_, _, _)
	setLocationForSSID()
end):start()

hs.hotkey.bind({'cmd','alt','shift'}, 'U', restartSquid)
