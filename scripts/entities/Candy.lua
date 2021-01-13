-- ANIMATIONS
-- idle
local Candy = {}
function Candy:new()
	local candy = {}

	function candy:init()
		self.sprite = display.newImage( "images/candy.png" )
		self.sprite.instance = self
		self.sprite.name = 'candy'
		physics.addBody(self.sprite, {
				density = 0.4, radius = 35, friction = 0.1
			})

		-- reset scene
		Runtime:addEventListener( 'enterFrame', candy )
	end

	function candy:setPosition(x, y)
		self.sprite.x, self.sprite.y = x, y
	end

	function candy:dispose()
		if self.sprite then
			self.sprite.instance = nil
			self.sprite:removeSelf()
			self.sprite = nil
		end
	end

	function candy:cancelEvents()
		if self.timer then
			timer.cancel( self.timer )
			self.timer = nil
		end
	end

	function candy:enterFrame(e)
		if self.sprite and self.sprite.y > Y then
			if not self.timer then
				self.timer = timer.performWithDelay( 1000, function (e)
					Runtime:removeEventListener( 'enterFrame', candy )
					self:cancelEvents()
					self.sprite:dispatchEvent({
							name = 'candyIsDead'
						})
					end )
				end
			else
				self:cancelEvents()
			end
		end

		candy:init()

		return candy
	end

	return Candy
