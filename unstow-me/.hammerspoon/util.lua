local log = hs.logger.new('util')

util = {}

function util.strip(s)
	  return s:gsub('^%s*(.-)%s*$', '%1')
end

return util
