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

	--! Set Animation Counter !--
	ctr = (ctr or 0) + dt

	--! Animate ball but don't start scrolling yet !--
	if kick.state.beginning and ball.can_move_right() then
		
		ball.move(ctr, scroll.interval)

	elseif kick.state.beginning and not ball.can_move_right() then		
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

	--! Auto scroll background until target is reached !--
	if kick.state.in_progress then

		bg.scroll(ctr, scroll.interval, scroll.x_step)
		player.scroll(ctr, scroll.interval, scroll.x_step)

		-- Stop moving background when target reached
		if bg.x <= kick.x then
			kick.state.in_progress = false
			kick.complete = true
		end
	end


	--! Flucuate Power Meter!--
	meter.fluctuate()

	--! Stop Power Meter !--
	if love.keyboard.isDown('space') and kick.state.ready then
		meter.enabled = false
		kick.x = ( (meter.strength + 1) * kick.multiplier) * -1
		kick.state.ready = false
		kick.state.beginning = true
	end

	--! Show result of kick !--
	if kick.complete then
		-- Set success / failure message
		message.kick.set(kick.x, goal.x)

		-- Reset everything back to beginning
		if love.keyboard.isDown('space') then
			kick.state.beginning = false
			kick.state.in_progress = false
			kick.complete = false
			kick.x = 0
			bg.x = bg.initial.x
			player.x = player.initial.x
			ball.x = ball.initial.x
			ball.y = ball.initial.y
			meter.strength = 0
			meter.direction = 'right'
			meter.enabled = true

		end
	end

	--! Update animation counter !--
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

	   -- Success / Failure of Kick
		if kick.complete then			
			message.kick.draw(msg_font)
	   	end


    end) -- end post processing

	-- Monitor Frame
    love.graphics.draw(frame_img, 0, 0)

   	-- Reset color
	love.graphics.setColor(255, 255, 255, 255)

	-- Diagnostic Panel
    diagnostics.draw(debug, diag_data)

end










