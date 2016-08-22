io.stdout:setvbuf('no')
debug = true
local shine = require 'shine'

function debug_print()

   love.graphics.setNewFont(12)
   love.graphics.setColor(0, 0, 0)
   love.graphics.rectangle('fill', 25, 35, 180, 130)

   love.graphics.setColor(255, 255, 255)
   love.graphics.print('bg.x: ' .. bg.x,  50, 50)

   love.graphics.setColor(255, 255, 255)
   love.graphics.print('meter strength: ' .. meter.strength,  50, 80)

   love.graphics.setColor(255, 255, 255)
   love.graphics.print('kick: ' .. kick.x,  50, 100)

   love.graphics.setColor(255, 255, 255)
   love.graphics.print('player.x' .. player.x,  50, 130)


end

function love.load(arg)
	love.window.setMode( 1280, 720)
	-- love.window.setFullscreen(true)
	msg_font   = love.graphics.newFont("assets/fonts/joystix.ttf", 40)

	-- Shaders
	local grain = shine.filmgrain()
	grain.opacity = 0.1

	local vignette = shine.vignette()
	vignette.opacity = 0.5

	local scanlines = shine.scanlines()
	scanlines.opacity = 0.1

	local crt = shine.crt()
	crt.x = 0.05
	crt.y = 0.05

	post_effect = grain:chain(vignette):chain(scanlines):chain(crt)

	-- Background Scrolling
	bg = { initial_x = -300, y = -24 }
	bg.x = bg.initial_x
	bg.img = love.graphics.newImage('assets/graphics/backgrounds/football_field_bg.png')
	love.graphics.setBackgroundColor( 0, 0, 0 )
	scroll = { interval = 0.1, x_step = 64}


	-- Monitor Frame
	frame_img = love.graphics.newImage('assets/graphics/backgrounds/monitor_Frame.png')

	-- Football Target
	kick = { x = 0, ready = true, multiplier = 17, in_progress = false, complete = false }
	meter = { strength = 0, max = 250, speed = 10, direction = 'right', enabled = true }
	goal = { x = -3400, message = nil }

	-- Player

	player = { initial_x = 600, y = 400 }
	player.x = player.initial_x
	player.img = love.graphics.newImage('assets/graphics/sprites/player.png')

	love.graphics.setDefaultFilter("nearest", "nearest")

end

function love.update(dt)
	-- require('lovebird').update()

	--! Auto scroll background until target is reached !--
	if kick.in_progress then

		-- Chunky scrolling to only scroll every x/fractions of a second
		-- Also specifies how many x coords to step forward each scroll
		ctr = (ctr or 0) + dt
		if ctr > scroll.interval then
		  bg.x = bg.x - scroll.x_step
		  player.x = player.x - scroll.x_step
		  ctr = ctr - scroll.interval
		end

		-- Stop moving background when target reached
		if bg.x <= kick.x then
			kick.in_progress = false
			kick.complete = true
		end
	end

	--! Flucuate Power Meter !--
	if meter.enabled then
		if meter.strength < meter.max and 
			meter.direction == 'right' then

			meter.strength = meter.strength + 1 * meter.speed

		elseif meter.strength > 0 and 
			meter.direction == 'left' then
			
			meter.strength = meter.strength - 1 * meter.speed
		end

		if meter.strength == meter.max then
			meter.direction = 'left'

		elseif meter.strength == 0 then
			meter.direction = 'right'
		end
	end

	--! Stop Power Meter !--
	if love.keyboard.isDown('space') and kick.ready then
		meter.enabled = false
		kick.x = ( (meter.strength + 1) * kick.multiplier) * -1
		kick.in_progress = true
		kick.ready = false
	end

	--! Show result of kick !--
	if kick.complete then
		-- Set success / failure message
		if kick.x <= -3380 then
			goal.message = 'SUCCESS!'
		else
			goal.message = 'FAILURE!'
		end

		-- Reset everything back to beginning
		if love.keyboard.isDown('space') then
			kick.in_progress = false
			kick.complete = false
			kick.x = 0
			bg.x = bg.initial_x
			player.x = player.initial_x
			meter.strength = 0
			meter.direction = 'right'
			meter.enabled = true
		end
	end
end

function love.keyreleased(key)
   if key == "space" then
      kick.ready = true
   end
end

function love.draw()

	post_effect:draw(function()

		-- Background 
		love.graphics.draw(bg.img, bg.x, bg.y)

		-- Player
	    love.graphics.draw(player.img, player.x, player.y)

	   -- Kick-O-Meter
	   love.graphics.setColor(255, 255, 255, 255)
	   love.graphics.rectangle('fill', 950, 60, 252, 30) -- Frame
	   love.graphics.setColor(0, 0, 0)
	   love.graphics.rectangle('fill', 952, 62, 248, 26) -- Background
	   love.graphics.setColor(118, 255, 97)
	   love.graphics.rectangle('fill', 952, 62, meter.strength, 26) -- Kick bar

	   -- Success / Failure of Kick

		if kick.in_progress or kick.complete then 
			love.graphics.setColor(99, 205, 83, 255)
			love.graphics.circle("fill", 1150, 450, 10, 50) -- Football
		end

		if kick.complete then

			love.graphics.setColor(38, 86, 95, 255)
	   		love.graphics.rectangle('fill', 320, 270, 660, 210) -- Frame

		    love.graphics.setColor(0, 0, 0)
	   		love.graphics.rectangle('fill', 352, 302, 596, 146) -- Background

			love.graphics.setFont(msg_font)
	   		love.graphics.setColor(255, 255, 255, 255)
		    love.graphics.print(goal.message, 530, 350) -- Message

	   	end

    end)
	love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(frame_img, 0, 0)

   -- Debug output
   if debug == true then
   		debug_print()
   	end

   	-- Reset color
end










