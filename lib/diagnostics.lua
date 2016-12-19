local diagnostics = {}

	-- Table of debug print messages
	dm = {}
	dm[#dm+1] = 'kick state complete: ' ..tostring(kick.state.complete)
	dm[#dm+1] = 'kick.target.x: ' .. kick.target.x
	dm[#dm+1] = 'ball initial: ' .. tostring(ball.initial.x)

	
	function diagnostics.draw(debug_enabled)

	   -- Only output debug info if global variable debug is true

		if debug_enabled == true then

			bg_color = {0, 57, 255}
			fg_color = {102, 144, 252}

			-- C64 border style
			love.graphics.setColor(fg_color)
			love.graphics.rectangle('fill', 0, 0, 300, 720)
			
			love.graphics.setColor(bg_color)
			love.graphics.rectangle('fill', 20, 20, 260, 680)

			love.graphics.setColor(fg_color)
			love.graphics.setNewFont(12)

			-- Position of each message w/ line spacing
			x = 50
			y = 60
			ls = 30
			
			-- Draw messages
			for k, v in ipairs(dm) do
				love.graphics.print(v, x, y)
				y = y + ls
			end

			-- Reset color
			love.graphics.setColor(255, 255, 255)

		end

	end

return diagnostics