module Views
	module Prompts
		######### A method used to get a 'nil' user input #######################################################################
		def self.tmpgets
			tmp = $stdin.gets
		end

		####### # A method used to print a message inside a box #################################################################
		def self.prompt(question, choices, halign: 95)
			prompt = TTY::Prompt.new(symbols: {marker: " "})
			prompt.select("#{question}\n".center(halign), choices, show_help: :never, cycle: true)
		end

		def self.command

		end

		# ######### A method to check if the entered command is valid ################################################################
		# def Parser::validatecommand(game, command)
		# 	cmd_parse = Parser::command(game, command)
		# 	cmd_parse = Parser::command(game, command.reverse) if not cmd_parse
			
		# 	if (!cmd_parse)
		# 	puts "\n\t\t\"#{command}\" is not a valid command. Enter \"H\" for help."
		# 	return false
		# 	end
		
		# 	return false if cmd_parse==-2  # Help command
			
		# 	if !game.get(cmd_parse[0], cmd_parse[1]).nil?
		# 	puts "\n\t\t\"#{command}\" is not an empty space"
		# 	return false
		# 	end
		
		# 	return cmd_parse
		# end
		
		# ####### A method that converts string commands to array indexes that refer to positions on the board ######################
		# def Parser::command(game, command)
		# 	commands = Array.new
		# 	case command[0]
		# 		when "A"
		# 		commands[0] = 0
		# 		when "B"
		# 		commands[0] = 1
		# 		when "C"
		# 		commands[0] = 2
		# 		when "H"
		# 		Views::GameInfo::showhelp()
		# 		return -2
		# 		when "R"
		# 		return false if not command[1].nil?
		# 		randomsquare = randomsquare(findemptysquares(game.board))
		# 		puts "\t\tRandom square: \"" + Parser::arraytocmd(randomsquare, game.commands) + "\""
		# 		return randomsquare
		# 		else
		# 		return false
		# 	end
			
		# 	case command[1..]
		# 		when "1"
		# 		commands[1] = 0
		# 		when "2"
		# 		commands[1] = 1
		# 		when "3"
		# 		commands[1] = 2
		# 		else
		# 		return false
		# 	end
			
		# 	return commands
		# end
			
		# #########  A method that converts board array values commands to grid display indices #############################
		# def Parser::arraytodisplay(command)
		# 	commands = Array.new
		# 	commands[0] = (command[0] < 3) ? (command[0] + 1)*2   : false
		# 	commands[1] = (command[1] < 3) ? ((command[1]+1)*4)+1 : false
		# 	return commands
		# end
			
		# #######  A method that converts board array values to array commands ##############################################
		# def Parser::arraytocmd(command, commands)
		# 	output = Array.new
		# 	output[0] = commands.key(command[0])
		# 	output[1] = (command[1]+1).to_s
		# 	return output.join.to_s
		# end		
	end
end