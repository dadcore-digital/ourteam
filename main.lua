io.stdout:setvbuf('no')
-- debug = true

function debug_print()
   love.graphics.setColor(0, 0, 0)
   love.graphics.rectangle('fill', 25, 35, 150, 100)

   love.graphics.setColor(255, 255, 255)
   love.graphics.print('bg.x: ' .. bg.x,  50, 50)

   love.graphics.setColor(255, 255, 255)
   love.graphics.print('meter strength: ' .. meter.strength,  50, 80)
end

function love.load(arg)
	love.window.setMode( 1280, 720)
	-- love.window.setFullscreen(true, 'exclusive')
	
	-- Background Scrolling
	bg = { x = 0, y = 0 }
	bg.img = love.graphics.newImage('assets/graphics/backgrounds/football_field_bg.png')
	love.graphics.setBackgroundColor( 0, 0, 0 )
	scroll = {rate = 80, step = 250, counter = 0}
	canscroll = true

	-- Football Target
	target = { x = -4000, reached = true }
	meter = { strength = 0, max = 252, speed = 9, direction = 'right', enabled = true }

end

function love.update(dt)
	require('lovebird').update()

	canscroll = true and scroll.counter == 0 or false

	--! Auto scroll background until target is reached !--
	if not target.reached then

		scroll.counter = scroll.counter + scroll.rate

		if canscroll == true then
			bg.x = bg.x - scroll.rate
		end

		if bg.x <= target.x then
			target.reached = true
		end
	end

	if scroll.counter >= scroll.step then
		scroll.counter = 0
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
	if love.keyboard.isDown('space') then
		meter.enabled = false
		target.x = (meter.strength * 17) * -1
		target.reached = false
	end


end

function love.draw()

	-- Background 
   love.graphics.draw(bg.img, bg.x, bg.y)

   -- Kick-O-Meter Frame
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.rectangle('fill', 1000, 50, 252, 30)
   love.graphics.setColor(0, 0, 0)
   love.graphics.rectangle('fill', 1002, 52, 248, 26)

   -- Kick-
   love.graphics.setColor(118, 255, 97)
   love.graphics.rectangle('fill', 1002, 52, meter.strength, 26)

   
   -- Debug output
   if debug == true then
   		debug_print()
   	end

   	-- Reset color
   	love.graphics.setColor(255, 255, 255, 255)
end










