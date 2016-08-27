local player = {}
	
	player.initial = {}
	
	player.initial.x 	= 500
	player.initial.y 	= 400 
	
	player.x 			= player.initial.x
	player.y 			= player.initial.y
	player.img 			= love.graphics.newImage('assets/graphics/sprites/player.png')

	function player.scroll(ctr, interval, x_step)

		-- Move the player backward (to left), given a counter and an interval used to
		-- only draw animations every x number of cycles.

		if ctr > scroll.interval then		  
		  player.x = player.x - scroll.x_step
		end

	end

	function player.draw()

		love.graphics.draw(player.img, player.x, player.y)

	end


return player