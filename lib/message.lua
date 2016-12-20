local message = {}

	message.kick = {}
	

	function message.kick.set(success)
		
		if success then
			message.kick.text = 'SUCCESS!'
		else
			message.kick.text = 'FAILURE!'
		end

	end


	function message.kick.draw(font, kick)

		if kick:is_complete() then
			love.graphics.setColor(38, 86, 95, 255)
			love.graphics.rectangle('fill', 320, 270, 660, 210) -- Frame

		    love.graphics.setColor(0, 0, 0)
			love.graphics.rectangle('fill', 352, 302, 596, 146) -- Background

			love.graphics.setFont(font)
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.print(message.kick.text, 530, 350) -- Message
		end
	end


return message