io.stdout:setvbuf('no')
debug = true

local k = require "vendor/katsudo"

camera 	  		= require 'lib/camera'
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

	-- Animations
	player.animation.load()

	if arg[#arg] == "-debug" then require("mobdebug").start() end

end


function love.update(dt)
	

	-- Utilities & Helpers
	if debug then require('vendor/lovebird').update() end

	-- Set Animation Counter
	ctr = (ctr or 0) + dt

	-- Update Animations
	player.animation.update(dt)

	--! Power meter start /stop !--
	-- Get that meter moving
	meter.fluctuate()

	-- Stop meter and start player running to kick --
	if love.keyboard.isDown('space') and kick.state.ready then
		
		meter.enabled = false
		player.start()

	end

	if love.keyboard.isDown('right') then
		camera:move(6, 0)
	end


	if love.keyboard.isDown('left') then
		camera:move(-6, 0)
	end

	--! Kick off Phase !--

	-- Player is running towards the ball --
	if player.run.in_progress and not player.can_kick() then
		player.animation.update(dt)
		player.move(dt)
	end

	-- Player has reached the ball and is kicking --
	if player.run.done then
		kick.start()
		player.ready()
	end

	--! Move ball once kick starts !--
	-- This will move ball as far right on screen as it can go,
	-- before whole screen starts scrolling.
	
	if kick.state_in_progress then	
		
		-- Move Ball
		ball.move_x(ball.speed, 0)
		-- camera:move(ball.speed, 0)

		if kick.target.reached(ball.x) then
			
			kick.state.in_progress = false
			kick.state.complete = true
		end

	end

	--! Show result of kick !--
	if kick.state.complete then
		
		-- Set kick success / failure and show message

		kick.set_success_fail(goal.x)
		message.kick.set(kick.success)

		-- Reset everything back to beginning
		if love.keyboard.isDown('space') then

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


function love.mousepressed(x, y, button, istouch)
	print(y)
	diagnostics:toggle(x, y, button)
end

function love.draw()


	post_effect:draw(function()

		camera:set()

			bg.draw()
			player.draw()
			meter.draw()
			ball.draw()
			message.kick.draw(msg_font, kick)
		
		camera:unset()


    end) -- end post processing

	-- Monitor Frame
    love.graphics.draw(frame_img, 0, 0)

   	-- Reset color
	love.graphics.setColor(255, 255, 255, 255)

	-- Diagnostic Panel
    diagnostics:draw(debug, diag_data)

end










