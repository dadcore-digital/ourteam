local crowd = {}


	-- Build table of spectators in crowd
	crowd.rows = 27
	crowd.cols = 36
	crowd.margin = {}
	crowd.margin.bottom = 3
	crowd.margin.right = 3
	crowd.speed = 50
	
	crowd.moving = {}
	crowd.moving.counter = 0
	crowd.moving.max = 3

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
				self.seating[r][c].start_x = self.seating[r][c].x
				self.seating[r][c].start_y = self.seating[r][c].y
				self.seating[r][c].state = 'seated'
				self.seating[r][c].counter = 0

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


	function crowd:antsy(dt)
		for r = 1, self.rows do
			for c = 1, self.cols do

				spectator = self.seating[r][c]

				if spectator.state == 'standing' and spectator.counter < 4 then
					spectator.y = spectator.y - (crowd.speed * dt)
					spectator.counter = spectator.counter + 1
				elseif spectator.state == 'standing' and spectator.counter >= 4 then
					spectator.state = 'sitting'
					spectator.counter = spectator.counter - 1
				end

				if spectator.state == 'sitting' and spectator.counter > 0 then					
					spectator.y = spectator.y + (crowd.speed * dt)
					spectator.counter = spectator.counter - 1
				elseif spectator.state == 'sitting' and spectator.counter == 0 then
					spectator.state = 'seated'
					self.moving.counter = self.moving.counter - 1
				end


				if math.random(25000) == 1 then
					if spectator.state == 'seated' and self.moving.counter < self.moving.max then
						spectator.state = 'standing'
						self.moving.counter = self.moving.counter + 1
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