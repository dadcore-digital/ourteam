io.stdout:setvbuf('no')
debug = true

bg 				= require 'lib/background'
player 			= require 'lib/player'
ball 			= require 'lib/ball'
kick 			= require 'lib/kick'
meter 			= require 'lib/meter'
message 		= require 'lib/message'
diagnostics 	= require 'lib/diagnostics'

function love.load(arg)

	-- Window Settings
	love.window.setMode( 1280, 720)

	-- Shaders
	post_effect = require 'lib/shaders'

	-- Fonts
	msg_font = love.graphics.newFont("assets/fonts/joystix.ttf", 40)

	-- Background & Frame Elements
	love.graphics.setBackgroundColor( 0, 0, 0 )
	frame_img = love.graphics.newImage('assets/graphics/backgrounds/monitor_Frame.png')

	-- Constants
	goal = { x = -3400 }
	scroll = { interval = 0.1, x_step = 64}

end


function love.update(dt)
	
	if debug then require('vendor/lovebird').update() end

	-- Set Animation Counter
	ctr = (ctr or 0) + dt

	-- Get that meter moving
	meter.fluctuate() 

	--! Move ball !--
	-- This will move ball as far right on screen as it can go,
	-- before whole screen starts scrolling.
	
	if kick.state.beginning and ball.can_move_right() then	
		
		-- Move Ball
		ball.move(ctr, scroll.interval)

	elseif kick.state.beginning and not ball.can_move_right() then		

		-- Ball has moved as far right it can go
		kick.state.beginning = false
		kick.state.in_progress = true

	end


	--! Animate ball rise and fall !--

	if kick.state.beginning or kick.state.in_progress then

		-- Decide whether to animate ball y rise
		animate_ball_rise = ball.y > ball.offset.apogee.y or false

		-- Decide whether to animate ball y fall
		animate_ball_fall = bg.x <= -3000 or false


		if ctr > scroll.interval then
	
			if animate_ball_rise then
				ball.y = ball.y - 20
			end

			if animate_ball_fall then
				ball.y = ball.y + 32
			end
		end

	end

	--! Scroll background until target is reached !--

	if kick.state.in_progress then

		-- Scroll background and player
		bg.scroll(ctr, scroll.interval, scroll.x_step)
		player.scroll(ctr, scroll.interval, scroll.x_step)

		-- Stop moving background when target reached
		if bg.x <= kick.x then
			kick.state.in_progress = false
			kick.state.complete = true
		end
	end



	--! Stop Power Meter and start Kck !--
	if love.keyboard.isDown('space') and kick.state.ready then
		meter.enabled = false
		kick.start()		
	end

	--! Show result of kick !--
	if kick.state.complete then
		
		-- Set success / failure message
		message.kick.set(kick.x, goal.x)

		-- Reset everything back to beginning
		if love.keyboard.isDown('space') then

			bg.reset()
			player.reset()
			ball.reset()
			kick.reset()
			meter.reset()

		end

	end

	--! Reset animation counter if interval hit !--
	while ctr  > scroll.interval do
		ctr = 0
	end

end


function love.keyreleased(key)
   if key == "space" then
      kick.state.ready = true
   end
end


function love.draw()

	post_effect:draw(function()

		bg.draw()
		player.draw()
		meter.draw()
		ball.draw()
		message.kick.draw(msg_font, kick)

    end) -- end post processing

	-- Monitor Frame
    love.graphics.draw(frame_img, 0, 0)

   	-- Reset color
	love.graphics.setColor(255, 255, 255, 255)

	-- Diagnostic Panel
    diagnostics.draw(debug, diag_data)

end










