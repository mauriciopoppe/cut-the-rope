-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Globals
globals = {
    WIDTH = display.contentWidth,
    HEIGHT = display.contentHeight
}

-- Utils
Vector = require 'scripts.utils.Vector'
GeometricUtils = require 'scripts.utils.GeometricUtils'

-- Composer
local composer = require "composer"

-- Load menu screen
composer.gotoScene("scenes.menu")
