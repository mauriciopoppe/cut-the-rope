-- ANIMATIONS
local sound = require "scripts.sound"
-- idle
local idleSheetInfo = require('animations.idle')
local idleSheet = graphics.newImageSheet( 'animations/idle.png', idleSheetInfo:getSheet() )
-- tilt
local tiltSheetInfo = require('animations.tilt')
local tiltSheet = graphics.newImageSheet( 'animations/tilt.png', tiltSheetInfo:getSheet() )
-- open mouth
local openMouthSheetInfo = require('animations.openMouth')
local openMouthSheet = graphics.newImageSheet( 'animations/openMouth.png', openMouthSheetInfo:getSheet() )
-- chew
local chewSheetInfo = require('animations.chew')
local chewSheet = graphics.newImageSheet( 'animations/chew.png', chewSheetInfo:getSheet() )
-- sad
local sadSheetInfo = require('animations.sad')
local sadSheet = graphics.newImageSheet( 'animations/sad.png', sadSheetInfo:getSheet() )

local sequence = {
	{
		name = 'idle',
		sheet = idleSheet,
		start = 1,
		count = 10,
		time = 1000,
		loopDirection = 'bounce',
		loopCount = 0
	},
	{
		name = 'tilt',
		sheet = tiltSheet,
		start = 1,
		count = 14,
		time = 500,
		loopCount = 0
	},
	{
		name = 'openMouth',
		sheet = openMouthSheet,
		start = 1,
		count = 8,
		time = 500,
		loopCount = 1
	},
	{
		name = 'openMouthReverse',
		sheet = openMouthSheet,
		frames = {8, 7, 6, 5, 4, 3, 2, 1},
		time = 500,
		loopCount = 1
	},
	{
		name = 'chew',
		sheet = chewSheet,
		frames = (function ()
			local t = {1, 2, 3}
			local cycles = 3
			local offset = 2
			for i=1, cycles do
				for j=2, 8 do
					table.insert(t, j + offset)
				end
				for j=7, 1, -1 do
					table.insert(t, j + offset)
				end
			end
			return t
		end)(),
		time = 3000
	},
	{
		name = 'sad',
		sheet = sadSheet,
		start = 1,
		count = 13,
		time = 500,
		loopCount = 1
	}
}

local OmNom = {
	name = 'omnom',
	timer = nil
}
OmNom.__index = OmNom

function OmNom:new()
	local omnom = display.newGroup()

	function omnom:init()
		-- character
		self.sprite = display.newSprite( idleSheet, sequence )
		self.sprite:addEventListener( 'collision', function (event)
			if event.phase == 'began' then
				if event.other.name == 'candy' and not self.collisionWithBody then
					self.collisionWithBody = true
					self:openMouthAnimation(candy)
				end
			elseif event.phase == 'ended' then
				if event.other.name == 'candy' and self.collisionWithBody then
					self.collisionWithBody = false
					self:closeMouthAnimation()
				end
			end
		end)
		physics.addBody(self.sprite, 'static', {
				radius = 150, friction = 0.8, isSensor = true
			})

		-- eat sensor
		local radius = 10
		self.eatRange = display.newCircle( 0, 0, radius )
		self.eatRange.alpha = 0
		physics.addBody( self.eatRange, 'static', { radius = radius, friction = 0.8, isSensor = true } )
		self.eatRange:addEventListener( 'collision', function (event)
			if event.phase == 'began' and event.other.name == 'candy' then
				self:chewAnimation(event.other)
			end
		end)

		-- tilt animation
		self.sprite:addEventListener( 'touch', function (e)
			if e.phase == 'began' then
				self:tiltAnimation()
				return true
			end
		end)
	end

	function omnom:idleAnimation()
		local sprite = self.sprite
		sprite:setSequence( 'idle' )
		sprite:play();
	end

	function omnom:tiltAnimation()
		local sprite = self.sprite
		sprite:setSequence( 'tilt' )
		sprite:play();

		self:cancelAnimation()
		self.timer = timer.performWithDelay( 1000, function (e)
			self:idleAnimation()
		end )
	end

	function omnom:chewAnimation(candy)
		local sprite = self.sprite

		-- remove the candy
		candy.instance:dispose()

		audio.stop(3)
		audio.play(sound.chew, { channel = 3 })
		sprite:setSequence( 'chew' )
		sprite:play();
		self.timer = timer.performWithDelay( 3000, function (e)
			self:idleAnimation()
		end )
	end

	function omnom:openMouthAnimation(candy)
		local sprite = self.sprite
		audio.stop(2)
		audio.play(sound.openMouth, { channel = 2 })
		self:cancelAnimation()
		sprite:setSequence( 'openMouth' )
		sprite:play()
	end

	function omnom:closeMouthAnimation()
		local sprite = self.sprite
		self:cancelAnimation()
		sprite:setSequence( 'openMouthReverse' )
		sprite:play()
		self.timer = timer.performWithDelay( 500, function (e)
			self:idleAnimation()
		end )
	end

	function omnom:sadAnimation()
		local sprite = self.sprite
		audio.stop(2)
		audio.play(sound.sad, { channel = 2 })
		self:cancelAnimation()
		sprite:setSequence( 'sad' )
		sprite:play()
	end

	function omnom:cancelAnimation()
		if self.timer then
			timer.cancel( self.timer )
			self.timer = nil
		end
	end

	function omnom:translate(dx, dy)
		self.sprite.x = self.sprite.x + dx
		self.sprite.y = self.sprite.y + dy
		self.eatRange.x = self.eatRange.x + dx
		self.eatRange.y = self.eatRange.y + dy
	end

	function omnom:dispose()
		self:cancelAnimation()
		self.sprite:removeSelf()
		self.eatRange:removeSelf()
		self.sprite = nil
		self.eatRange = nil
	end

	-- omnom init
	omnom:init()

	return omnom
end

return OmNom
