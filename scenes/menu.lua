-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer"
local widget = require "widget"
local graphics = require "graphics"
local scene = composer.newScene()
local sound = require "scripts.sound"
local button = require "scripts.button"

function scene:create(event)
	local group = self.view
	local background = display.newImageRect("images/menubg.jpg", 1024, 576)
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	background.rotation = 90
	group:insert(background)

	local gameTitle = display.newImageRect("images/logo.png", 339, 301)
	gameTitle.x = display.contentWidth / 2
	gameTitle.y = display.contentHeight / 2 - 80
	group:insert(gameTitle)

	local function onPlayButtonRelease()
        audio.stop()
        audio.play(sound.game, {
            loops = -1,
            fadeIn = 500
        })
		composer.gotoScene("scenes.game", "fade", 500)
	end

	local playButton = button.factory('Play', onPlayButtonRelease)
	playButton.x = display.contentWidth / 2
	playButton.y = display.contentHeight / 2 + 200
	group:insert(playButton)

end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

    if (phase == "will") then
        audio.stop()
        audio.play(sound.menu)
    end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
return scene
