local crowd = {}


	-- Build table of spectators in crowd
	crowd.rows = 27
	crowd.cols = 36
	crowd.margin = {}
	crowd.margin.bottom = 3
	crowd.margin.right = 3

	spectator_blue = love.graphics.newImage('assets/graphics/sprites/spectator_blue.png')
	spectator_green = love.graphics.newImage('assets/graphics/sprites/spectator_green.png')
	crowd.spectator_width, crowd.spectator_height = spectator_blue:getDimensions()

	crowd.seating = {}

	function crowd:fill_seats(left, top)
		-- Top / Left: x, y positions of where crowd should be on screen

		for r = 1, self.rows do
			self.seating[r] = {}
		end

		for r = 1, self.rows do 
			for c = 1, self.cols do
				
				self.seating[r][c] = {}
				self.seating[r][c].x = left + ( c * (self.spectator_width + self.margin.right) )
				self.seating[r][c].y = top + ( r * (self.spectator_height + self.margin.bottom) )

				if r % 2 == 0 then -- Even rows go: Green / Blue / Green
					if c % 2 == 0 then
						self.seating[r][c].img = spectator_blue
					else
						self.seating[r][c].img = spectator_green
					end

				else -- Odd rows go: Blue / Green / Blue
					if c % 2 == 0 then
						self.seating[r][c].img = spectator_green
					else
						self.seating[r][c].img = spectator_blue
					end
				end

			end
		end
	end

	function crowd:draw()

		for r = 1, self.rows do
			for c = 1, self.cols do

				spectator = self.seating[r][c]				
				love.graphics.draw(spectator.img, spectator.x, spectator.y)

			end
		end			

	end

return crowd