local k = require "vendor/katsudo"

local bg = {}

	bg.x 					= 0
	bg.y 					= -24
	bg.img 					= love.graphics.newImage('assets/graphics/backgrounds/football_field_bg.png')



	function bg.draw()

		love.graphics.draw(bg.img, bg.x, bg.y)
		
	end

return bg






