local ball = {}

	ball.initial = {}

	ball.initial.x = 700
	ball.initial.y = 442

	ball.x = ball.initial.x
	ball.y = ball.initial.y

	-- Track how far the ball has travelled from kickoff
	ball.speed = .005
	ball.progress = 0
	ball.path = nil

	ball.img = love.graphics.newImage('assets/graphics/sprites/football.png')


	function ball.set_path(target)

		ball.midpoint 	= ball.initial.x + ( target / 2 )
		ball.apogee   	= ball.initial.y - 900
		ball.path 		= love.math.newBezierCurve( ball.initial.x, ball.initial.y, ball.midpoint, ball.apogee, target + ball.initial.x, ball.initial.y )

	end		

	function ball.move(dt)

		if ball.progress <= 1 then
			ball.x, ball.y = ball.path:evaluate(ball.progress)
			ball.progress = ball.progress + ball.speed
		end

	end


	function ball.reset()

		ball.x = ball.initial.x
		ball.y = ball.initial.y
		ball.progress = 0
		ball.path = nil

	end


	function ball.draw()

		love.graphics.draw(ball.img, ball.x, ball.y)
		
		if ball.path and debug then
			love.graphics.line(ball.path:render(5))
		end

	end

return ball