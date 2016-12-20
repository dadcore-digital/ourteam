local kick = {}
	
	kick.target = {}
	kick.target.x 				= 0 
	kick.multiplier 			= 17
	kick.success 				= false

	-- These four states control the flow of the game:	
	-- 1. Ready for kick off
	-- 2. Kick has surpassed the bounds of the original screen
	-- 3. Kick has reached its final destination
	
	kick.STATES = {ready = 1, in_progress = 2,  complete = 3}
	kick.state = kick.STATES.ready

	function kick.start()
		
		kick.target.x = (meter.strength + 1) * kick.multiplier
		kick.state = kick.STATES.in_progress

	end

	function kick.target.reached(ball_distance)

		-- Calculate if target has been reached by comparing
		-- background x position vs target x position.

		if ball_distance >= kick.target.x and kick.target.x ~= 0 then
			return true
		end

		return false

	end

	function kick.set_success_fail(goal_x)
		
		if kick.target.x >= goal_x then
			kick.success = true
		else
			kick.success = false
		end

	end


	function kick.reset()

		kick.state = kick.STATES.ready
		kick.target.x = 0
		kick.success = false

	end

	function kick:is_ready()
		if self.state == self.STATES.ready then
			return true
		end

		return false

	end	

	function kick:is_in_progress()
		if self.state == self.STATES.in_progress then
			return true
		end

		return false

	end	

	function kick:is_complete()
		if self.state == self.STATES.complete then
			return true
		end

		return false

	end	

return kick