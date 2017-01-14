local k = require "vendor/katsudo"

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

	ball.animation = {}
	ball.animation.ready = love.graphics.newImage('assets/graphics/sprites/football.png')
	ball.animation.state = 'ready'
	ball.animation.speed = .09

	-- Shadow of Ball 
	ball.shadow  = {}
	ball.shadow.initial = {}
	ball.shadow.initial.x = ball.initial.x
	ball.shadow.initial.y = ball.initial.y + 10

	ball.shadow.x = ball.shadow.initial.x
	ball.shadow.y = ball.shadow.initial.y

	ball.shadow.animation = {}
	ball.shadow.animation.ready = love.graphics.newImage('assets/graphics/sprites/football_shadow.png')

	function ball.animation.load()

 		ball.animation.moving  = k.new("/assets/graphics/sprites/football_sheet.png", 20, 20, 4, ball.animation.speed, 'rough')
		ball.shadow.animation.moving  = k.new("/assets/graphics/sprites/football_shadow_sheet.png", 20, 20, 4, ball.animation.speed, 'rough')
	end

	function ball.animation.update(dt)

		ball.animation.moving:update(dt)
		ball.shadow.animation.moving:update(dt)

	end

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

		ball.animation.state = 'moving'

		if ball.progress <= 1 then
			ball.x, ball.y = ball.path:evaluate(ball.progress)
			ball.progress = ball.progress + ball.speed

			ball.shadow.x = ball.x
		end

	end


	function ball.reset()

		ball.x = ball.initial.x
		ball.y = ball.initial.y
		ball.shadow.x = ball.shadow.initial.x
		ball.progress = 0
		ball.path = nil
		ball.animation.state = 'ready'

	end


	function ball.draw()

		if ball.animation.state == 'ready' then

			love.graphics.draw(ball.shadow.animation.ready, ball.shadow.x, ball.shadow.y)
			love.graphics.draw(ball.animation.ready, ball.x, ball.y)

		elseif ball.animation.state == 'moving' then
			
			ball.shadow.animation.moving:draw(ball.shadow.x, ball.shadow.y, 0, 1, 1)
			ball.animation.moving:draw(ball.x, ball.y, 0, 1, 1)

		end
		
		if ball.path and debug then
			love.graphics.line(ball.path:render(5))
		end

	end

return ball