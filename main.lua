io.stdout:setvbuf('no')
debug = true

function love.load(arg)
	love.window.setMode( 1280, 720)
	bg = { x = 0, y = 0 }
	bg.img = love.graphics.newImage('assets/graphics/backgrounds/football_field_bg.png')
	love.graphics.setBackgroundColor( 0, 0, 0 )
	scroll = {rate = 150, step = 800, counter = 0}
end

function love.update(dt)
	-- require('lovebird').update()
	-- Testing screen scrolling
	if scroll.counter == 0 then
		canscroll = true
	else
		canscroll = false
	end

	if love.keyboard.isDown('right') then
		
		scroll.counter = scroll.counter + scroll.rate

		if bg.x > -4480 and canscroll == true then
			bg.x = bg.x - scroll.rate
		end
	end

	if love.keyboard.isDown('left') then
		scroll.counter = scroll.counter + scroll.rate
		if bg.x < 0 and canscroll then
			bg.x = bg.x + scroll.rate			
		end
	end

	if scroll.counter >= scroll.step then
		scroll.counter = 0
	end

end

function love.draw()
   love.graphics.draw(bg.img, bg.x, bg.y)
   love.graphics.print('canscroll ' .. scroll.counter, 50, 50)
end
