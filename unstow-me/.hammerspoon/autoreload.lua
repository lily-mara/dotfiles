function reloadConfig()
	hs.reload()
	hs.notify.show('Hammerspoon', 'Config reloaded', '')
end
hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfig):start()
