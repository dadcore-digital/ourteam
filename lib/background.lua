local bg = {}
	
	bg.initial = {}

	bg.initial.x = -300
	bg.initial.y = -24 
	
	bg.x = bg.initial.x
	bg.y = 0
	bg.img = love.graphics.newImage('assets/graphics/backgrounds/football_field_bg.png')
	
	function bg.scroll(ctr, interval, x_step)

		-- Move the background forward, given a counter and an interval used to
		-- only draw animations every x number of cycles.

		if ctr > interval then
		  bg.x = bg.x - x_step
		end

	end


	function bg.draw()

		love.graphics.draw(bg.img, bg.x, 0)

	end

return bg