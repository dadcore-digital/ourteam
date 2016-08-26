--! Power Meter Controls Kick Strength !--

local meter = {}

-- Default Meter Settings
meter.strength 	= 0
meter.max 		= 250
meter.speed 	= 10
meter.direction = 'right'
meter.enabled 	= true


function meter.fluctuate()

	if meter.enabled then

		if meter.strength < meter.max and 
			meter.direction == 'right' then

			meter.strength = meter.strength + 1 * meter.speed

		elseif meter.strength > 0 and 
			meter.direction == 'left' then
			
			meter.strength = meter.strength - 1 * meter.speed
		end

		if meter.strength == meter.max then
			meter.direction = 'left'

		elseif meter.strength == 0 then
			meter.direction = 'right'
		end
	end
end

function meter.draw()
	   love.graphics.setColor(255, 255, 255, 255)
	   love.graphics.rectangle('fill', 950, 60, 252, 30) -- Frame
	   love.graphics.setColor(0, 0, 0)
	   love.graphics.rectangle('fill', 952, 62, 248, 26) -- Background
	   love.graphics.setColor(118, 255, 97)
	   love.graphics.rectangle('fill', 952, 62, meter.strength, 26) -- Kick bar
end

return meter