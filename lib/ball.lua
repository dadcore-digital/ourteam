local ball = {}

	ball.initial = {}

	ball.initial.x = 700
	ball.initial.y = 442

	ball.x = ball.initial.x
	ball.y = ball.initial.y

	-- Track how far the ball has travelled from kickoff
	ball.distance = 0
	ball.progress = 1
	ball.speed = 8
	ball.path = nil

	ball.img = love.graphics.newImage('assets/graphics/sprites/football.png')


	function ball.set_path(target)

		ball.midpoint 	= ball.initial.x + ( target / 2 )
		ball.apogee   	= ball.initial.y - 1000
		ball.path 	= love.math.newBezierCurve( ball.initial.x, ball.initial.y, ball.midpoint, ball.apogee, target + ball.initial.x, ball.initial.y )
		-- ball.path 	= ball.path:render(5)

	end		

	function ball.move()

		ball.x = ball.path[ball.progress]
		ball.y = ball.path[ball.progress]+ 1

		ball.progress = ball.progress + 2

	end

	function ball.move_x(speed)
		
		-- Move the ball forward, given a counter and an interval used to
		-- only draw animations every x number of cycles.

		ball.x 			= ball.x + speed
		ball.distance 	= ball.x - ball.initial.x		
		
	end

	function ball.reset()

		ball.x = ball.initial.x
		ball.y = ball.initial.y
		ball.distance = 0

	end


	function ball.draw()

		love.graphics.draw(ball.img, ball.x, ball.y)
		
		if ball.path then
			love.graphics.line(ball.path:render(5))
		end

	end

return ball