io.stdout:setvbuf('no')
debug = true
local shine = require 'shine'

local meter = require 'meter'
local message = require 'message'

function debug_print()

   love.graphics.setNewFont(12)
   love.graphics.setColor(0, 0, 0)
   love.graphics.rectangle('fill', 25, 35, 180, 160)

   love.graphics.setColor(255, 255, 255)
   love.graphics.print('bg.x: ' .. bg.x,  50, 50)

   love.graphics.setColor(255, 255, 255)
   love.graphics.print('meter strength: ' .. meter.strength,  50, 80)

   love.graphics.setColor(255, 255, 255)
   love.graphics.print('kick: ' .. kick.x,  50, 100)

   love.graphics.setColor(255, 255, 255)
   love.graphics.print('player.x' .. player.x,  50, 130)

   love.graphics.setColor(255, 255, 255)
   love.graphics.print('ball.x' .. ball.x,  50, 160)


end

function love.load(arg)
	love.window.setMode( 1280, 720)
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

	-- Set non-cheering crowd as default as well as animation frame
	bg.img = love.graphics.newImage('assets/graphics/backgrounds/football_field_bg.png')

	love.graphics.setBackgroundColor( 0, 0, 0 )
	scroll = { interval = 0.1, x_step = 64}


	-- Monitor Frame
	frame_img = love.graphics.newImage('assets/graphics/backgrounds/monitor_Frame.png')

	-- Football Target
	kick = { x = 0, ready = true, multiplier = 17, beginning = false, in_progress = false, complete = false }
	goal = { x = -3400 }

	-- Player

	player = { initial_x = 500, y = 400 }
	player.x = player.initial_x
	player.img = love.graphics.newImage('assets/graphics/sprites/player.png')

	-- Ball
	ball = {
			initial_x = 700,
			initial_y = 442,
			scroll_start_offset_x = 350,
			apogee_offset_y = 100
		}
	ball.x = ball.initial_x
	ball.y = ball.initial_y
	ball.img = love.graphics.newImage('assets/graphics/sprites/football.png')


	love.graphics.setDefaultFilter("nearest", "nearest")

end

function love.update(dt)
	require('lovebird').update()

	--! Set Animation Counter !--
	ctr = (ctr or 0) + dt
	bg_ctr = (bg_ctr or 0) 

	--! Animate ball but don't start scrolling yet !--
	if kick.beginning and 
		ball.x <= ball.initial_x + ball.scroll_start_offset_x then

	-- Animate ball
	if ctr > scroll.interval then
		ball.x = ball.x + 64
	end

	elseif kick.beginning and 
		ball.x > ball.initial_x + ball.scroll_start_offset_x then
		kick.beginning = false
		kick.in_progress = true
	end

	--! Animate ball rise and fall !--

	if kick.beginning or kick.in_progress then

		-- Decide whether to animate ball y rise
		animate_ball_rise = ball.y > ball.apogee_offset_y or false

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
	if kick.in_progress then

		-- Chunky scrolling to only scroll every x/fractions of a second
		-- Also specifies how many x coords to step forward each scroll
		if ctr > scroll.interval then
		  bg.x = bg.x - scroll.x_step
		  player.x = player.x - scroll.x_step
		end

		-- Stop moving background when target reached
		if bg.x <= kick.x then
			kick.in_progress = false
			kick.complete = true
		end
	end



	--! Flucuate Power Meter!--
	meter.fluctuate()

	--! Stop Power Meter !--
	if love.keyboard.isDown('space') and kick.ready then
		meter.enabled = false
		kick.x = ( (meter.strength + 1) * kick.multiplier) * -1
		kick.ready = false
		kick.beginning = true
	end

	--! Show result of kick !--
	if kick.complete then
		-- Set success / failure message
		message.set_kick_text(kick.x, goal.x)

		-- Reset everything back to beginning
		if love.keyboard.isDown('space') then
			kick.beginning = false
			kick.in_progress = false
			kick.complete = false
			kick.x = 0
			bg.x = bg.initial_x
			player.x = player.initial_x
			ball.x = ball.initial_x
			ball.y = ball.initial_y
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
      kick.ready = true
   end
end

function love.draw()

	post_effect:draw(function()

		-- Background 
		love.graphics.draw(bg.img, bg.x, bg.y)

		-- Player
	    love.graphics.draw(player.img, player.x, player.y)

	   -- Kick-O-meter
	   meter.draw()

	   -- Success / Failure of Kick

		if kick.complete then
			message.kick.draw(msg_font)

	   	end

    -- Ball
	love.graphics.draw(ball.img, ball.x, ball.y)	    

    end)
	love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(frame_img, 0, 0)


   -- Debug output
   if debug == true then
   		debug_print()
   	end

   	-- Reset color
end










