require_relative "./Parser.rb"
require_relative "./AI.rb"
require_relative "./Logic.rb"
require_relative "./MoveRecord.rb"
require_relative "../views/Display.rb"
require_relative "./Player.rb"
require "uuid"
require "json"
require "tty-table"
require "date"

$foo    = 0       # A global variable used to store the number of iterations
$encmbr = 0       # A global variable for encumbrance percentage % (default: 0))

########################################################################################
# The Game class that creates a new instance of the game every time
########################################################################################
class Game
	attr_accessor :moverecord
	attr_reader :commands, :playermode, :player, :board, :board_display, :filename
	
	########### Initialise the Game class ###############################################
	def initialize
		reset()
		@commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2}
		@filename = "./gameresults.json"
		@halign = 95
	end

	########### Reset the board #######################################################
	def reset()
		@board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
		@moverecord = MoveRecord.new(@filename)
		@board_display = Views::Display::board()
	end

	######### Start the main GAME LOOP ################################################
	def startgame(simulation_mode=false)
		
		reset()
		if not simulation_mode
			Player.reset
			@playermode = Views::Prompts::prompt("Choose (1)-player or (2)-player mode:", {"(1)-Player Mode".center(@halign) => 1, "(2)-Player Mode".center(@halign) => 2, "Cancel".center(@halign) => 0} )
			return if @playermode == 0
			@player = requestplayernames(@playermode)

			nextplayer = selectfirstplayer(@player)
			@moverecord.setplayers(Player.names)
			showboard()
		
			begin
				nextplayer = nextgameplayer?(nextplayer) ? computermove(nextplayer) : playermove(nextplayer)
			end while not (checkgameover())
			endgame()
	
		else
			@player = requestplayernames(1)
			begin
				print "\n\t\tEnter number of simulations: "
				nsim = gets.chomp
				print "\t\t\"#{nsim}\" is not a valid number of simulations. Please enter a valid input.\n" if (nsim.to_i <= 0)
			end while (nsim.to_i <= 0)
		
			([nsim.to_i,1000].min).times do # To prevent crashes, the max number of simulations is capped at 1000
				nextplayer = cointoss()[0]
				@moverecord.setplayers(Player.names)
				
				begin
					nextplayer = computermove(nextplayer)  
				end while not (checkgameover())
				endgame()
				reset()
			end
		end
	end	

	########### Set the value on the board #############################################
	def entermove(coord, val)
		drow,dcol = Parser::arraytodisplay(coord)
		board[coord[0]][coord[1]] = val
		board_display[drow][dcol] = ['O','X'][val]
		showboard()
	end

	########### Get the value on a particular square on the board ######################
	def get(row, col)
		board[row][col]
	end

	########### Draw the board ########################################################
	def showboard()
		@board_display.map do |row|
			str = row.split("X").join("X".light_red)
			str = str.split("O").join("O".light_blue)
			puts "\t\t\t\t\t" + str
		end
	end

	########## Get the player names and save them in a hash ############################
	def requestplayernames(playermode)
		@player = Array.new    # Set default values below
		@player[0] = Player.new("Player 1")
		@player[1] = Player.new("Player 2")
	
		# Get player names
		for i in 0..playermode-1
			@player[i].requestname(i)
			@player[1].name = (playermode == 1) ? "Computer" : next
		end
	
		# Welcome the players
		print (playermode == 1) ? "\n\n\t\tWelcome #{@player[0].name}!" : "\n\n\t\tWelcome #{@player[0].name} and #{@player[1].name}!"
		Views::Prompts::tmpgets
	
		return player
	end

	########## Generate a cointoss, assign X and O ###################################
	def cointoss()
		c_toss = rand()
		# puts c_toss
		ctoss = c_toss.round
		@player.each do |player|
			player.setval(ctoss)
			ctoss = swapval(ctoss)
		end
		return [Player.find(1), ['T','H'][ctoss]]
	end	


	########## Select first player based on cointoss results ##########################
	def selectfirstplayer(player)
		# Coin toss
		print "\n\n\t\tTossing coin now...(Press ENTER to see coin toss results)"
		Views::Prompts::tmpgets
		currentplayer = cointoss()

		puts "\n\t\tThe result of the coin toss is: \n\n"
		puts "\t\t\t\t\t\t\t  -------  "
		puts "\t\t\t\t\t\t\t/         \\"
		puts "\t\t\t\t\t\t\t|    #{currentplayer[1]}    |"
		puts "\t\t\t\t\t\t\t\\         /"
		print "\t\t\t\t\t\t\t  -------- "
		Views::Prompts::tmpgets
	
		puts "\n\t\t#{player[0].name} is \'#{player[0].str}\'. #{player[1].name} is \'#{player[1].str}\'.\n\n"
		print "\t\t#{currentplayer[0].name} goes first..."
		Views::Prompts::tmpgets
	
		return currentplayer[0]
	end

	######## Let the player play the next move #####################################################################
	def playermove(currentplayer)
		begin
			print "\n\t\t#{currentplayer.name}, please enter a command (or \"H\" for Help): "
			command = gets.chomp.strip.upcase.delete(' ')
			puts "\n\t\tYou (#{currentplayer.str}) entered: \"#{command}\""
			cmd_parse = Parser::validatecommand(self, command)
		end while not cmd_parse

		@moverecord.push(cmd_parse)
		entermove(cmd_parse,currentplayer.val)
		return Player.find(swapval(currentplayer.val))
	end

	####### Let the computer play the next move ####################################################################
	def computermove(currentplayer)
		computer_response = AI::response(@board, currentplayer.val)
		print @moverecord.length == 0 ? "\n\n\t\tComputer's (#{currentplayer.str}) first move: " : "\n\t\tComputer (#{currentplayer.str}) responds: "
		@moverecord.push(computer_response)
		command_response = Parser::arraytocmd(computer_response, @commands)
		print "\"#{command_response}\"\n"
		entermove(computer_response,currentplayer.val)
		print "\n\t\tPerformed #{$foo} iterations...\n" if ($foo > 0)
		return Player.find(swapval(currentplayer.val))
	end
	
	######## # Return the next player ###############################################################################
	def nextgameplayer?(nextplayer)
		return ((@playermode == 1) and (nextplayer == @player[1]))
	end	

	######### Load a saved game ######################################################################################
	def load()
		nlines = 0
		lines = []
		linesUUIDs = []

		file = File.open(@filename)
		File.foreach(@filename).with_index do |line,i|
			begin
				eachline = JSON.parse(line)
				lines << eachline
				linesUUIDs << {("Game ID: " + eachline["UUID"][0..7].to_s + " @ " + eachline["DateTime"]).center(@halign) => i}
		 		nlines += 1
			rescue StandardError
				return puts "\t\t"+"-"*75+"\n\t\tUnable to load game save file.\n\n\t\tThe game save file \"#{@filename}\" is either corrupt or appears to have been tampered with.\n\n\t\tPlease delete the file \"#{@filename}\" and create a new one.\n\t\t"+"-"*75
			end
			
		end
		file.close

		puts "\n Total number of games to load from: #{nlines}\n\n\n"
		request = Views::Prompts::prompt("Choose which game to display: ", linesUUIDs)
		moves = lines[request]["Moves"]
		movesarray = []
		moves.each.with_index { |move,i| movesarray.push (i % 2 == 0) ? [Parser::arraytocmd(move, @commands),""] : ["",Parser::arraytocmd(move, @commands)] }
		movesarray.push(["--------","--------"])
		movesarray.push(["Winner: ",lines[request]["Winner"]])
		table = TTY::Table.new(lines[request]["Players"], movesarray)
		table.render(:ascii).split("\n").each { |table_line| puts table_line.center(@halign) }
	end


	###### Check game over status ###############################################################################################
	def checkgameover()
		(Logic::checkdraw(@board) or Logic::checkwin(@board))
	end


	###### Displays endgame ###################################################################################################
	def endgame()
		winner = Logic::checkwin(@board)
		puts "\n\n"
		if (winner)
			winnername = Player.find(winner)
			@moverecord.setwinner(winnername.name + ": " + ['O','X'][winner])
			Views::Display::printbox("#{winnername.name} wins!") if @playermode == 2
			Views::Display::printbox(winner==@player[0].val ? "You win!" : "You lose!") if @playermode == 1

		elsif (Logic::checkdraw(@board))
			Views::Display::printbox("Game is a draw!")
			@moverecord.setwinner("Draw")
		end

		puts "\n\n\t\tResults automatically saved to #{@moverecord.filename}\n\n\n"
		@moverecord.record[:DateTime] = Time.now.strftime("%d/%m/%Y %H:%M:%S")
		File.write(@moverecord.filename,(@moverecord.record).to_json + "\n", mode: 'a')
  	end
end