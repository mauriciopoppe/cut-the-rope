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
	background.x = halfX
	background.y = halfY
	background.rotation = 90
	group:insert(background)

	local gameTitle = display.newImageRect("images/logo.png", 339, 301)
	gameTitle.x = halfX
	gameTitle.y = halfY - 80
	group:insert(gameTitle)

	local function onPlayButtonRelease()
		composer.gotoScene("scenes.game", "fade", 500)
	end

	local playButton = button.factory('Play', onPlayButtonRelease)
	playButton.x = halfX
	playButton.y = halfY + 200
	group:insert(playButton)

	-- sound
	audio.play( sound.menu )
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		local prevScene = composer.getSceneName( "current" )
		if (composer.getSceneName(prevScene) ~= nil) then
			composer.purgeScene(prevScene)
			composer.removeScene(prevScene)
		end
	end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
return scene
