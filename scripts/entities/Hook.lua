local Rope = require 'scripts.entities.Rope'

local Hook = {}

function Hook:new()
	local hook = {}

	function hook:init()
		-- sprite
		self.sprite = display.newImage('images/hook_big.png')
		self.sprite.name = 'hook'
		physics.addBody(self.sprite, 'static', {
				density = 0.1, radius = 15, isSensor = true
			})

		-- hook range
		local range = 100
		self.hookRange = display.newCircle( self.sprite.x, self.sprite.y, range )
		-- self.hookRange.alpha = 0
		self.hookRange.strokeWidth = 5
		self.hookRange:setFillColor( 0, 0, 0, 0 )
		self.hookRange:setStrokeColor( 71/255, 175/255, 217/255 )

		self.hookRange.name = 'hookRange'
		physics.addBody(self.hookRange, 'static', {
				radius = range, isSensor = true
			})

		-- detect collisions with the candy
		self.hookRange:addEventListener( 'collision', function (e)
			if e.phase == 'began' then
				if e.other.name == 'candy' then
					timer.performWithDelay( 0, function ()
						self:join(e.other.instance)
					end)
				end
			end
		end)

	end

	function hook:join(candy)
		self.candy = candy

		local sx, sy = self.sprite.x, self.sprite.y
		local cx, cy = candy.sprite.x, candy.sprite.y

		self.rope = Rope:new(sx, sy, cx, cy, 30)
		self.rope:concatTwoEnds( self.sprite, candy.sprite )

		-- dispose the hook range
		self.hookRange:removeSelf()
		self.hookRange = nil

		-- fire an event in the candy to indicate that
		-- a hook was joined with a candy
		candy.sprite:dispatchEvent({
				name = 'join',
				hook = self
			})

	end

	function hook:setPosition(x, y)
		self.sprite.x = x
		self.sprite.y = y
		self.hookRange.x = x
		self.hookRange.y = y
	end

	function hook:checkIntersections(rect)

		-- **** SEGMENT INTERSECTION ****
		-- if hook.joint == nil then return end

		-- local hookA, hookB, rectA, rectB
		-- hookA = Vector:new(hook.sprite.x, hook.sprite.y)
		-- hookB = Vector:new(hook.candy.sprite.x, hook.candy.sprite.y)

		-- rectA = Vector:new(rect.x, rect.y)

		-- -- rotate the second vector again
		-- local angle = math.rad(rect.rotation or 0)
		-- local vx = rect.width

		-- --[[
		-- 	[cos -sin
		-- 	 sin  cos]
		-- 	[ x , y ] = [ x cos A - y sin A, x sin A + y cos A ]
		-- --]]
		-- rectB = Vector:new(rect.x + vx * math.cos(angle),
		-- 	rect.y + vx * math.sin(angle))
		-- -- print ('checkIntersections: ', hookA, hookB, rectA, rectB)

		-- if GeometricUtils:segmentsIntersect(hookA, hookB, rectA, rectB) then
		-- 	hook.joint:removeSelf()
		-- 	hook.joint = nil
		-- end

		-- **** ROPE INTERSECTION ****
		if not hook.rope then return end
		local rectA = Vector:new(rect.x, rect.y)
		local angle = math.rad(rect.rotation or 0)
		local vx = rect.width
		--[[
			[cos -sin
			 sin  cos]
			[ x , y ] = [ x cos A - y sin A, x sin A + y cos A ]
		--]]
		local rectB = Vector:new(rect.x + vx * math.cos(angle),
			rect.y + vx * math.sin(angle))

		local index = hook.rope:intersectionWithSegment(rectA, rectB)
		if index then
			hook.rope:cutAndDispose(index)
			hook.rope = nil
		end
	end

	function hook:dispose()
		self.sprite:removeSelf()
		self.sprite = nil
		if self.rope then
			self.rope:dispose()
			self.rope = nil
		end
		if self.hookRange then
			self.hookRange:removeSelf()
			self.hookRange = nil
		end
	end

	hook:init()

	return hook
end

return Hook
