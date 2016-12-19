local kick = {}
	
	kick.state = {}
	kick.target = {}
	kick.target.x 				= 0 
	kick.multiplier 			= 17
	kick.success 				= false

	-- These four states control the flow of the game:
	
	-- 1. Ready for kick off
	kick.state.ready 			= true

	-- 2. Kick has surpassed the bounds of the original screen
	kick.state.in_progress 		= false

	-- 3. The kick is nearing completion but hasn't touched ground
	kick.state.ending 			= false

	-- 4. Kick has reached its final destination
	kick.state.complete 		= false	
				

	function kick.start()
		
		kick.target.x = (meter.strength + 1) * kick.multiplier
		kick.state.ready = false
		kick.state.in_progress = true

	end


	function kick.target.reached(ball_x)

		-- Calculate if target has been reached by comparing
		-- background x position vs target x position.

		if ball_x >= kick.target.x then
			return true
		end

		return false

	end

	function kick.set_success_fail(goal_x)
		
		if kick.target.x <= goal_x then
			kick.success = true
		else
			kick.success = false
		end

	end


	function kick.reset()

		kick.state.beginning = false
		kick.state.in_progress = false
		kick.state.complete = false
		kick.target.x = 0
		kick.success = false

	end

return kick