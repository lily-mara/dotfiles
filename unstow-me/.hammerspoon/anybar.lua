local util = require('util')

local log = hs.logger.new('AnyBar')

AnyBar = {}

local function startAnyBarCallback(exitCode, stdout, stderr)
	if not exitCode == 0 then
		log.e('AnyBar failed', stdout, stderr)
	end
end

local function startAnyBar(port)
	task = hs.task.new(
		'/Applications/AnyBar.app/Contents/MacOS/AnyBar',
		startAnyBarCallback,
		util.buildOutputStreamLogger(log),
		{}
	)
	task:setEnvironment({
		ANYBAR_PORT=port
	})
	task:start()

	return task
end

function AnyBar:new(port)
	local p = port or 1738
	local t = {
		port=p,
		socket=hs.socket.udp.new(),
		task=startAnyBar(p)
	}
    setmetatable(t, { __index=self })
	return t
end

function AnyBar:setColor(color)
	self.socket:send(color, 'localhost', self.port)

	return self
end

function AnyBar:close()
	self.socket:close()
end

return AnyBar
