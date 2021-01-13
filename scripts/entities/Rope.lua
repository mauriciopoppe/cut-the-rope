local Rope = {}

function Rope:new(x1, y1, x2, y2, n)
	local rope = {
		segments = {},
		joints = {},
		nJoints = nil
	}

	local function makeJoint(a, b)
		local joint = physics.newJoint( 'distance',
			a, b, a.x, a.y, b.x, b.y )
		-- joint.length = 5
		-- joint.frequency = 1
		-- joint.dampingRatio = 0.5
		-- print(joint.length, joint.frequency, joint.dampingRatio)
		table.insert( rope.joints, joint )
	end

	function rope:init()
		n = n or 5
		for i=1, n do
			local x = x1 + (x2 - x1) * i / n
			local y = y1 + (y2 - y1) * i / n
			local segment = display.newCircle( x, y, 5 )
			physics.addBody( segment, {
					density = 0.1, radius = 10, isSensor = true
				} )
			segment:setFillColor(135/255, 89/255, 50/255)
			table.insert( self.segments, segment )
		end

		for i=2, n do
			local prev = self.segments[i - 1]
			local curr = self.segments[i]
			makeJoint(prev, curr)
		end
		self.nJoints = n - 1
	end

	function rope:concatTwoEnds(left, right)
		local joint
		local first = self.segments[1]
		local last = self.segments[#self.segments]

		makeJoint(left, first)
		makeJoint(last, right)

		-- move objects to the front
		left:toFront()
		right:toFront()
	end

	function rope:intersectionWithSegment(C, D)
		local n = #self.segments
		for i=2, n do
			local prev = self.segments[i - 1]
			local curr = self.segments[i]
			local A = Vector:new(prev.x, prev.y)
			local B = Vector:new(curr.x, curr.y)
			local AB = B:sub(A)

			if GeometricUtils:segmentsIntersect(A, B, C, D) then
				return i - 1
			end
		end
		return nil
	end

	function rope:cutAndDispose(index)
		print('rope cut')
		-- hide the segments from 1 to index
		index = index or 1
		for i=1, index do
			transition.to(self.segments[i], {
					alpha = 0,
					time = 1000
				})
		end

		-- destrpy the segment that was intersected
		self.joints[index]:removeSelf()
		self.joints[index] = nil

		-- hide the segments from index + 1 to #length
		for i=index+1, #self.segments do
			transition.to(self.segments[i], {
					alpha = 0,
					time = 1000
				})
		end

		timer.performWithDelay( 1001, function (e) self:dispose() end )
	end

	function rope:dispose()
		print ('rope disposed')
		for i=1, self.nJoints do
			if self.joints[i] then
				self.joints[i]:removeSelf()
				self.joints[i] = nil
			end
		end
		for i=1, #self.segments do
			self.segments[i]:removeSelf()
			self.segments[i] = nil
		end
	end

	rope:init()

	return rope
end

return Rope
