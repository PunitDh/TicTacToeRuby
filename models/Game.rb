require_relative "./game-parser.rb"
require_relative "./artificial-intelligence.rb"
require_relative "./game-play.rb"
require_relative "./game-logic.rb"
require_relative "../views/game-display.rb"
require_relative "../views/DisplayBoard.rb"
require_relative "./MoveRecord.rb"
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
	
	
	# Initialise the Game class
	def initialize
		reset()
		@commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2}
		@filename = "./gameresults.json"
	end

	# A method to reset the board
	def reset()
		@board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
		@moverecord = MoveRecord.new(@filename)
		@board_display = Views::DisplayBoard.board()
		
	end

	# A method to set the value on the board
	def entermove(coord, val)
		drow,dcol = arraytodisplayparser(coord)
		board[coord[0]][coord[1]] = val
		board_display[drow][dcol] = ['O','X'][val]
		showboard()
	end

	# A method to get the value on a particular square on the board
	def get(row, col)
		board[row][col]
	end

	# A method to get the player names and save them in a hash
	def requestplayernames(playermode)
		@player = Array.new    # Set default values below
		@player[0] = Player.new("Player 1")
		@player[1] = Player.new("Player 2")
	
		# Get player names
		for i in 0..playermode-1
		getname(@player[i], i)
		@player[1].name = (playermode == 1) ? "Computer" : next
		end
	
		# Welcome the players
		print (playermode == 1) ? "\n\n\t\tWelcome #{@player[0].name}!" : "\n\n\t\tWelcome #{@player[0].name} and #{@player[1].name}!"
		tmpgets
	
		return player
	end

	# A method to draw the board
	def showboard()
		@board_display.map.with_index do |row,i|
		str = @board_display[i].split("X").join("X".light_red)
		str = str.split("O").join("O".light_blue)
		puts "\t\t\t\t\t" + str
		end
	end

	#############################################################################
	# The main GAME LOOP
	#############################################################################
	def startgame(simulation_mode=false)
		halign = 95
		reset()
		if not simulation_mode
			Player.reset
			@playermode = prompt("Choose (1)-player or (2)-player mode:", {"(1)-Player Mode".center(halign) => 1, "(2)-Player Mode".center(halign) => 2, "Cancel".center(halign) => 0} )
			return if @playermode == 0
			@player = requestplayernames(@playermode)

			nextplayer = selectfirstplayer(@player)
			@moverecord.setplayers(Player.names)
			showboard()
		
			# Game loop
			begin
				nextplayer = nextgameplayer?(self, nextplayer) ? computermove(self, nextplayer) : playermove(self, nextplayer)
			end while not (checkgameover())
		
			# Game end state
			endgame()
	
		else
			@player = requestplayernames(1)
			begin
				print "\n\t\tEnter number of simulations: "
				nsim = gets.chomp
				print "\t\t\"#{nsim}\" is not a valid number of simulations. Please enter a valid input.\n" if (nsim.to_i <= 0)
			end while (nsim.to_i <= 0)
		
			([nsim.to_i,1000].min).times do # To prevent crashes, the max number of simulations is capped at 1000
				nextplayer = cointoss(@player)[0]
				@moverecord.setplayers(Player.names)
				
				begin
					nextplayer = computermove(self,nextplayer)  
				end while not (checkgameover())
				endgame()
				reset()
			end
		end
	end	

	#############################################################################
	# Load a saved game
	#############################################################################
	def load()
		nlines = 0
		lines = []
		linesUUIDs = []

		file = File.open(@filename)
		
		File.foreach(@filename).with_index do |line,i|
			begin
				eachline = JSON.parse(line)
			rescue StandardError => exception
				return puts "\t\t"+"-"*75+"\n\t\tUnable to load game save file.\n\n\t\tThe game save file \"#{@filename}\" is either corrupt or appears to have been tampered with.\n\n\t\tPlease delete the file \"#{@filename}\" and create a new one.\n\t\t"+"-"*75
			end
			lines << eachline
			linesUUIDs << {("Game ID: " + eachline["UUID"][0..7].to_s + " @ " + eachline["DateTime"]).center(90) => i}
		 nlines += 1
		end

		puts "\n Total number of games to load from: #{nlines}"
		puts "\n"
		puts ""

		request = prompt("Choose which game to display: ", linesUUIDs)
		moves = lines[request]["Moves"]
		movesarray = []
		moves.each.with_index { |move,i| movesarray.push (i % 2 == 0) ? [arraytocommandsparser(move, @commands).join,""] : ["",arraytocommandsparser(move, @commands).join] }
		movesarray.push(["--------","--------"])
		movesarray.push(["Winner: ",lines[request]["Winner"]])
		table = TTY::Table.new(lines[request]["Players"], movesarray)
		table.render(:ascii).split("\n").each { |table_line| puts table_line.center(90) }
		file.close
	end

	# A method to check game over status
	def checkgameover()
		(checkdraw(@board) or checkwin(@board))
	end

	# A method that displays endgame
	def endgame()
		winner = checkwin(@board)
		puts "\n\n"
		if (winner)
			winnername = Player.find(winner)
			@moverecord.setwinner(winnername.name + ": " + ['O','X'][winner])
			printbox((@playermode == 1) ? "You lose!" : "#{winnername.name} won!")
		
		elsif (checkdraw(@board))
			printbox("Game is a draw!")
			@moverecord.setwinner("Draw")
		end

		puts "\n\n\t\tResults automatically saved to #{@moverecord.filename}\n\n\n"
		@moverecord.record[:DateTime] = Time.now.strftime("%d/%m/%Y %H:%M:%S")
		File.write(@moverecord.filename,(@moverecord.record).to_json + "\n", mode: 'a')
  	end
end