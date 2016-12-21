local diagnostics = {}
	
	diagnostics.show = true

	function diagnostics:draw(debug_enabled)

		-- Table of debug print messages
		dm = { 
				'[ BALL ]',
				'initial: ' .. tostring(ball.initial.x),
				'x: ' .. tostring(ball.x),
				'y: ' .. tostring(ball.y),
				'distance: ' .. tostring(ball.distance),
				'goal: ' .. tostring(goal.x),
				'curve start x, y: ' .. tostring(ball.initial.x) .. ', ' ..tostring(ball.initial.y),
				'curve midpoint x, y: ' .. tostring(ball.midpoint) .. ', ' .. tostring(ball.apogee),
				'curve end x, y: ' .. tostring(kick.target.x + ball.initial.x) .. ', ' .. tostring(ball.initial.y),
				'','[ PLAYER ]',
				'x: ' .. tostring(player.x),
				'state: ' .. tostring(player.state),
				'is_ready: ' .. tostring(player:is_ready()),
				'is_in_progress: ' .. tostring(player:is_in_progress()),
				'is_complete: ' .. tostring(player:is_complete()),
				
				'','[ KICK ]',
				'target.x: ' .. tostring(kick.target.x),
				'state: ' ..tostring(kick.state),
				'is_ready: ' .. tostring(kick:is_ready()),
				'is_in_progress: ' .. tostring(kick:is_in_progress()),
				'is_complete: ' .. tostring(kick:is_complete()),

			 }

		diagnostics.area = {0, 0, 300, 720}

	   -- Only output debug info if global variable debug is true

		if debug_enabled and self.show then

			bg_color = {0, 57, 255}
			fg_color = {102, 144, 252}

			-- C64 border style
			love.graphics.setColor(fg_color)
			love.graphics.rectangle('fill', unpack(self.area))
			
			love.graphics.setColor(bg_color)
			love.graphics.rectangle('fill', 20, 20, 260, 680)

			love.graphics.setColor(fg_color)
			love.graphics.setNewFont(12)

			-- Position of each message w/ line spacing
			x = 50
			y = 50
			ls = 20
			
			-- Draw messages
			for k, v in ipairs(dm) do
				love.graphics.print(v, x, y)
				y = y + ls
			end

			-- Reset color
			love.graphics.setColor(255, 255, 255)

		end

	end

function diagnostics:toggle(x, y, button)

	-- Toggle whether diagnostic panel is visible by clicking w/
	-- mouse in diagnostics area

	if (x >  self.area[1] and x < self.area[3]) and
	   (y > self.area[2] and y < self.area[4]) and
	   button == 1 then

	   self.show = not self.show
	end


end	

return diagnostics