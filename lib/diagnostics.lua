local diagnostics = {}

	
	function diagnostics.draw(debug_enabled)

	   -- Only output debug info if global variable debug is true

		if debug_enabled == true then

			love.graphics.setNewFont(12)
			love.graphics.setColor(0, 0, 0)
			love.graphics.rectangle('fill', 25, 35, 200, 200)

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

			love.graphics.setColor(255, 255, 255)
			can_descend = bg.x <= (kick.target.x + 1000)					
			love.graphics.print('ball can descend: ' .. tostring(can_descend),  50, 190)


		end

	end

return diagnostics