local player = {}
	
	player.initial 			= {}
	
	player.initial.x 		= 500
	player.initial.y 		= 400 
	
	player.x 				= player.initial.x
	player.y 				= player.initial.y
	player.img 				= love.graphics.newImage('assets/graphics/sprites/player.png')

	player.run 				= {}
	player.run.ready 		= true
	player.run.in_progress 	= false
	player.run.done			= false
	player.run.length 		= 180


	player.step 			= {}
	player.step.x 			= 24


	function player.scroll(ctr, interval, x_step)

		-- Move the player backward (to left), given a counter and an interval used to
		-- only draw animations every x number of cycles.

		if ctr > scroll.interval then		  
		  player.x = player.x - scroll.x_step
		end

	end

	function player.start()

		-- Player has begun the run up to the kick

		player.run.ready 		= false
		player.run.in_progress 	= true

	end

	function player.stop()

		-- Player has reached the ball is kicking
		
		player.run.in_progress 	= false
		player.run.done 		= true

	end

	function player.ready()

		-- Player has kicked the ball

		player.run.ready 		= true
		player.run.done 		= false

	end	

	function player.can_kick()

		-- Checks if player is in position to initiate kick
		if player.x >= player.initial.x + player.run.length then
			player.stop()
			return true
		end

		return false

	end


	function player.move(ctr, interval)
		
		-- Move the player forward, given a counter and an interval used to
		-- only draw animations every x number of cycles.
		
			if ctr > interval then
				player.x = player.x + player.step.x
			end
	
	end


	function player.reset()

		player.run.ready 		= true
		player.run.running 		= false
		player.run.done 		= false
		
		player.x 				= player.initial.x
	
	end


	function player.draw()

		love.graphics.draw(player.img, player.x, player.y)

	end


return player