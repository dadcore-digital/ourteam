local ball = {}

	ball.initial = {}
	ball.offset = { scroll_start = {}, apogee = {} }
	ball.step = {}

	ball.initial.x = 700
	ball.initial.y = 442

	ball.x = ball.initial.x
	ball.y = ball.initial.y

	ball.offset.scroll_start.x = 350
	ball.offset.apogee.y = 100

	ball.step.x = 64
	ball.step.y = 32

	ball.ascent = {}
	ball.descent = {}

	ball.ascent.reached 	= false
	ball.descent.reached	= false

	ball.ascent.y 			= 32
	ball.descent.y 			= ball.initial.y

	ball.img = love.graphics.newImage('assets/graphics/sprites/football.png')


	function ball.can_move_right()
		
		-- If there is remaining space for the ball to move to the right on the
		-- screen, returns true.

		-- An offset is used to determine the maximum

		if ball.x <= ball.initial.x + ball.offset.scroll_start.x then
			return true
		end

		return false
	
	end

	function ball.can_descend(background_x, target_x)
		-- Checks if the ball is within a certain distance of the target,
		-- and returns true if so.

		if bg.x <= (kick.target.x + 500) then
			return true
		end

		return false

	end

	function ball.move_x(ctr, interval)
		
		-- Move the ball forward, given a counter and an interval used to
		-- only draw animations every x number of cycles.

		if ctr > interval then
			ball.x = ball.x + ball.step.x
		end
	
	end

	function ball.ascend(ctr, interval)
		
		if ctr > interval then
			ball.x = ball.x + ball.step.x
			ball.y = ball.y - 64
		end
	end

	function ball.descend(ctr, interval)
		
		if ctr > interval then
			if ball.y < ball.initial.y then
				ball.y = ball.y + 64
			end
		end
	end


	function ball.reset()

		ball.x = ball.initial.x
		ball.y = ball.initial.y

	end


	function ball.draw()

		love.graphics.draw(ball.img, ball.x, ball.y)

	end

return ball