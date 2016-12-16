local diagnostics = {}

	
	function diagnostics.draw(debug_enabled)

	   -- Only output debug info if global variable debug is true

		if debug_enabled == true then

			love.graphics.setNewFont(12)
			love.graphics.setColor(0, 0, 0)
			love.graphics.rectangle('fill', 25, 35, 180, 160)

			love.graphics.setColor(255, 255, 255)
			love.graphics.print('bg.x: ' .. bg.x,  50, 50)

			love.graphics.setColor(255, 255, 255)
			love.graphics.print('kick state complete: ' ..tostring(kick.state.complete),  50, 80)

			love.graphics.setColor(255, 255, 255)
			love.graphics.print('kick.target.x: ' .. kick.target.x,  50, 100)

			love.graphics.setColor(255, 255, 255)
			love.graphics.print('ball initial: ' .. tostring(ball.initial.x),  50, 130)

			love.graphics.setColor(255, 255, 255)
			love.graphics.print('ball path' .. tostring(ball.path),  50, 160)
		
		end

	end

return diagnostics