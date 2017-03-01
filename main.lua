io.stdout:setvbuf('no')
debug = false

local k = require "vendor/katsudo"
local push = require "vendor/push"

camera 	  		= require 'lib/camera'
bg 				= require 'lib/background'
player 			= require 'lib/player'
ball 			= require 'lib/ball'
kick 			= require 'lib/kick'
crowd			= require 'lib/crowd'
meter 			= require 'lib/meter'
message 		= require 'lib/message'
diagnostics 	= require 'lib/diagnostics'



function love.load(arg)

	-- Window Settings
	local gameWidth, gameHeight = 1280, 720 --fixed game resolution
	local windowWidth, windowHeight = love.window.getDesktopDimensions()
	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = true, canvas = true })
	
	-- Shaders
	post_effect = require 'lib/shaders'

	-- Fonts
	msg_font = love.graphics.newFont("assets/fonts/joystix.ttf", 40)

	-- Background & Frame Elements
	love.graphics.setBackgroundColor( 0, 0, 0 )
	frame_img = love.graphics.newImage('assets/graphics/backgrounds/monitor_Frame.png')

	-- Crowd
	crowd:fill_seats(4700, 10)

	-- Constants
	goal = { x = 3900 }
	interval = 100

	-- Animations
	player.animation.load()
	ball.animation.load()
	bg.animation.load()

	if arg[#arg] == "-debug" then require("mobdebug").start() end

	-- Temp Debug Stuff
	if debug then
		camera.x = 4160
	end

end

function love.update(dt)
	

	-- Utilities & Helpers
	if debug then
		require('vendor/lovebird').update()
		if love.keyboard.isDown('left') then 
			camera.x = camera.x - 20
		elseif love.keyboard.isDown('right') then
			camera.x = camera.x + 20
		end
	end

	-- Update Animations
	player.animation.update(dt)

	--! Power meter start /stop !--
	-- Get that meter moving
	meter.fluctuate() 


	--! Kick off Phase !--
	-- Player is running towards the ball --
	if player:is_in_progress() and not player.can_kick() then
		player.animation.update(dt)
		player.move(dt)
	end

	-- Player has reached the ball and is kicking --
	if player:is_complete() then
		player.state = player.STATES.ready
		kick.start()
		ball.set_speed_apogee(kick.target.x)
		ball.set_path(kick.target.x)
	end

	--! Move ball once kick starts !--
	if kick:is_in_progress() then	

		-- Move Ball
			if ball.x < kick.target.x + ball.initial.x then
					ball.move(dt)
					camera:setPosition(ball.x - 700, 0)
			end


		if ball.progress >= 1 then
			kick.state = kick.STATES.complete
		end

	end

	--! Show result of kick !--
	if kick:is_complete() then
		
		-- Set kick success / failure and show message

		kick.set_success_fail(goal.x)
		message.kick.set(kick.success)
		bg.animation.start()

		-- Reset everything back to beginning
		if love.keyboard.isDown('space') then
			bg.animation.stop()
			player.reset()
			ball.reset()
			kick.reset()
			meter.reset()
			camera:setPosition(0,0)
		end

	end

end

function love.keypressed(key)
   if key == "space" then

	-- Stop meter and start player running to kick --
	if kick:is_ready() then		
		meter.enabled = false
		player.start()
	end

   end
end
 

function love.mousepressed(x, y, button, istouch)
	diagnostics:toggle(x, y, button)
end

function love.draw()


	push:start()

	post_effect:draw(function()

		camera:set()

			bg.draw()
			player.draw()
			crowd:draw()
			ball.draw(kick)
		
		camera:unset()


		meter.draw()
		message.kick.draw(msg_font, kick)


	end) -- end post processing

	-- Monitor Frame
	love.graphics.draw(frame_img, 0, 0)

	-- Reset color
	love.graphics.setColor(255, 255, 255, 255)

	-- Diagnostic Panel
	diagnostics:draw(debug, diag_data)
	push:finish()
end










