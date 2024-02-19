local hyper = hs.hotkey.modal.new({}, nil)

hyper.pressed = function()
	hyper:enter()
end
hyper.released = function()
	hyper:exit()
end

-- Hyper mode needs to be bound to a key. Here we are binding
-- it to F17, because this is yet another key that's unused.
-- Why not F18? We will use key-events from F18 to turn hyper
-- mode on and off. Using F17 as both the modal and source of key
-- events will result in a very jittery Hyper mode.
hs.hotkey.bind({}, "F18", hyper.pressed, hyper.released)

hyper.bindApp = function(mods, key, app)
	local fn = function()
		hs.application.launchOrFocus(app)
	end
	if type(app) == "function" then
		fn = app
	end
	hyper:bind(mods, key, fn)
end

return hyper
