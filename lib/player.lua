local k = require "vendor/katsudo"

local player = {}
	
	player.initial 			= {}
	
	player.initial.x 		= 350
	player.initial.y 		= 393 
	
	player.x 				= player.initial.x
	player.y 				= player.initial.y
	player.img 				= love.graphics.newImage('assets/graphics/sprites/player.png')

	player.STATES			= { ready = 1, in_progress = 2, complete = 3}
	player.state 			= player.STATES.ready
	player.run_length 		= 345


	player.speed			= 300

	player.animation 		= {}
	player.animation.state  = 'stopped'

	function player.animation.load()

 		player.animation.player  = k.new("/assets/graphics/sprites/player_sheet.png", 26, 68, 2, .3, 'rough')

	end

	function player.animation.update(dt)

		player.animation.player:update(dt)

	end

	function player.animation.start()
		player.animation.state = 'playing'
	end

	function player.animation.stop()
		player.animation.state = 'stopped'
	end


	function player.start()

		-- Player has begun the run up to the kick

		player.state 			= player.STATES.in_progress
		player.animation.state 	= 'playing'

	end

	function player.stop()

		-- Player has reached the ball is kicking
		
		player.state 			= player.STATES.complete
		player.animation.state  = 'stopped'

	end

	function player.ready()

		-- Player has kicked the ball

		player.state 			= player.STATES.ready

	end	

	function player.can_kick()

		-- Checks if player is in position to initiate kick
		if player.x >= player.initial.x + player.run_length then
			player.stop()
			return true
		end

		return false

	end


	function player.move(dt)
		
		-- Move the player forward, given a counter and an interval used to
		-- only draw animations every x number of cycles.
		
			player.x = player.x + (player.speed * dt)
	
	end


	function player.reset()

		player.state 			= player.STATES.ready
		player.x 				= player.initial.x
	
	end


	function player.draw()


		if player.animation.state == 'stopped' then

			love.graphics.draw(player.img, player.x, player.y)
		
		elseif player.animation.state == 'playing' then

			player.animation.player:draw (player.x,  player.y, 0, 1, 1)

		end


	end


	function player:is_ready()
		if self.state == self.STATES.ready then
			return true
		end

		return false
	end

	function player:is_in_progress()
		if self.state == self.STATES.in_progress then
			return true
		end

		return false
	end	

	function player:is_complete()
		if self.state == self.STATES.complete then
			return true
		end

		return false
	end	

return player