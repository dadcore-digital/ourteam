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

	
	function ball.move(ctr, interval)
		
		-- Move the ball forward, given a counter and an interval used to
		-- only draw animations every x number of cycles.

		if ctr > interval then
			ball.x = ball.x + ball.step.x
		end
	
	end

	function ball.draw()
		love.graphics.draw(ball.img, ball.x, ball.y)
	end

return ball