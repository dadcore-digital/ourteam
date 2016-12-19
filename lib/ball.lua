local ball = {}

	ball.initial = {}

	ball.initial.x = 700
	ball.initial.y = 442

	ball.x = ball.initial.x
	ball.y = ball.initial.y

	ball.speed = 8

	ball.img = love.graphics.newImage('assets/graphics/sprites/football.png')


	function ball.move_x(speed)
		
		-- Move the ball forward, given a counter and an interval used to
		-- only draw animations every x number of cycles.

		ball.x = ball.x + speed
	
	end

	function ball.reset()

		ball.x = ball.initial.x
		ball.y = ball.initial.y

	end


	function ball.draw()

		love.graphics.draw(ball.img, ball.x, ball.y)

	end

return ball