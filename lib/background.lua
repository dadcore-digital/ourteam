local k = require "vendor/katsudo"

local bg = {}
	
	bg.initial = {}

	bg.initial.x = -300
	bg.initial.y = -24 
	
	bg.x = bg.initial.x
	bg.y = bg.initial.y
	bg.img = love.graphics.newImage('assets/graphics/backgrounds/football_field_bg.png')

	bg.animation = {}
	bg.animation.state = {}

	bg.animation.state = 'stopped'


	function bg.animation.load()

		-- Cue up crowd animation at program start
		-- Should be executed inside of love.load()

 		bg.animation.player  = k.new("/assets/graphics/backgrounds/football_field_sheet.png", 5760, 720, 2, 0.5, 'rough')

	end

	function bg.animation.update(dt, kick)



		if kick.state.complete and kick.success then
			bg.animation.start()
			bg.animation.player:update(dt)
		else
			bg.animation.stop()
		end

	end

	function bg.animation.start()
		bg.animation.state = 'playing'
	end

	function bg.animation.stop()
		bg.animation.state = 'stopped'
	end


	function bg.scroll(ctr, interval, x_step)

		-- Move the background forward, given a counter and an interval used to
		-- only draw animations every x number of cycles.

		if ctr > interval then
		  bg.x = bg.x - x_step
		end

	end


	function bg.reset()
		bg.x = bg.initial.x
	end	

	function bg.draw()


		if bg.animation.state == 'stopped' then

			love.graphics.draw(bg.img, bg.x, bg.y)
		
		elseif bg.animation.state == 'playing' then

			bg.animation.player:draw (bg.x,  bg.y, 0, 1, 1)

		end


	end

return bg






