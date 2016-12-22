local ball = {}

	ball.initial = {}

	ball.initial.x = 700
	ball.initial.y = 442

	ball.x = ball.initial.x
	ball.y = ball.initial.y

	-- Track how far the ball has travelled from kickoff
	ball.speed = nil
	ball.time = nil
	ball.progress = 0
	ball.path = nil

	-- 4000 / 0.00375 = 1066666
	-- 2000 / 0.00375 = 533,333

	ball.img = love.graphics.newImage('assets/graphics/sprites/football.png')


	function ball.set_speed_apogee(target)
		if target > 0 and target < 1000 then
			ball.speed = 0.016
			ball.apogee = ball.initial.y - 400
		elseif target > 1000 and target < 2000 then
			ball.speed = 0.010
			ball.apogee = ball.initial.y - 700
		elseif target > 2000 and target < 3000 then
			ball.speed = 0.008
			ball.apogee = ball.initial.y - 800
		else 
			ball.speed = 0.006
			ball.apogee = ball.initial.y - 900
		end
	end

	function ball.set_path(target)

		ball.midpoint 	= ball.initial.x + ( target / 2 )
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