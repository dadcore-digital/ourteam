local kick = {}
	
	kick.state = {}

	kick.x 						= 0 
	kick.multiplier 			= 17
	
	kick.state.ready 			= true
	kick.state.beginning 		= false
	kick.state.in_progress 		= false
	kick.state.complete 		= false	
				

	function kick.start()
		kick.x = ( (meter.strength + 1) * kick.multiplier) * -1
		kick.state.ready = false
		kick.state.beginning = true
	end

	function kick.reset()

		kick.state.beginning = false
		kick.state.in_progress = false
		kick.state.complete = false
		kick.x = 0

	end

return kick