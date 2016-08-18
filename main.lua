io.stdout:setvbuf('no')
debug = true

function debug_print()
   love.graphics.setColor(0, 0, 0)
   love.graphics.rectangle('fill', 25, 35, 150, 50)

   love.graphics.setColor(255, 255, 255)
   love.graphics.print('bg.x: ' .. bg.x,  50, 50)
end

function love.load(arg)
	love.window.setMode( 1280, 720)
	
	-- Background Scrolling
	bg = { x = 0, y = 0 }
	bg.img = love.graphics.newImage('assets/graphics/backgrounds/football_field_bg.png')
	love.graphics.setBackgroundColor( 0, 0, 0 )
	scroll = {rate = 80, step = 500, counter = 0}
	canscroll = true

	-- Football Target
	target = { x = -4000, reached = false }

end

function love.update(dt)
	require('lovebird').update()

	canscroll = true and scroll.counter == 0 or false

	-- Auto scroll background until target is reached
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

end

function love.draw()
   love.graphics.draw(bg.img, bg.x, bg.y)

   
   -- Debug output
   if debug == true then
   		debug_print()
   	end

end
