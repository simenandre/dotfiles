local hyper = require("hyper")
hyper.install("F18")

hyper.bindKey("a", function()
	hs.application.launchOrFocus("Arc")
end)

hyper.bindKey("w", function()
	hs.application.launchOrFocus("Warp")
end)

hyper.bindKey("e", function()
	hs.application.launchOrFocus("iTerm")
end)

hyper.bindKey("s", function()
	hs.application.launchOrFocus("Slack")
end)

hyper.bindKey("1", function()
	hs.application.launchOrFocus("1Password")
end)

hyper.bindKey("r", function()
	hs.application.launchOrFocus("Rize")
end)

hyper.bindKey("d", function()
	hs.application.launchOrFocus("Obsidian")
end)

hyper.bindKey("c", function()
	hs.application.launchOrFocus("Google Chrome")
end)

hyper.bindKey("t", function()
	hs.application.launchOrFocus("Notification Center")
end)

hyper.bindKey("m", function()
	hs.application.launchOrFocus("Messages")
end)
