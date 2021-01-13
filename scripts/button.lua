local graphics = require "graphics"
local widget = require "widget"

local button = {}
local options = {
	width = 303,
	height = 70,
	numFrames = 2
}
local buttonImage = graphics.newImageSheet( "images/buttons.png", options )

function button.factory(label, fn)
	local playButton = widget.newButton({
		label = label,
		onRelease = fn,
		labelColor = {
			default = {1, 1, 1},
			over = {1, 1, 1, 0.8}
		},
		fontSize = 30,
		sheet = buttonImage,
		defaultFrame = 2,
		overFrame = 1
	})
	return playButton
end

return button
