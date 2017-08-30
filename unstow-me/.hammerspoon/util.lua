local log = hs.logger.new('util')

util = {}

function util.strip(s)
	  return s:gsub('^%s*(.-)%s*$', '%1')
end

function util.buildOutputStreamLogger(logger)
	return function (task, stdout, stderr)
		out = util.strip(stdout)
		err = util.strip(stderr)
		if string.len(out) > 0 then
			logger.i(out)
		end

		if string.len(err) > 0 then
			logger.e(err)
		end

		return true
	end
end

return util
