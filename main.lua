-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- Globals
X,Y = display.contentWidth, display.contentHeight
halfX, halfY = X * 0.5, Y * 0.5
centerX, centerY = display.contentCenterX, display.contentCenterY

-- Utils
Vector = require 'scripts.utils.Vector'
GeometricUtils = require 'scripts.utils.GeometricUtils'

-- Composer
local composer = require "composer"

-- Load menu screen
composer.gotoScene( "menu" )
