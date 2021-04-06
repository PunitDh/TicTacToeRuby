#############################################################################
# The Game class that creates a new instance of the game every time
#############################################################################
class Game
	attr_accessor :moverecord
	attr_reader :commands, :playermode, :player, :board, :board_display, :filename
	
	def initialize
		reset()
		@commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2}
		@filename = "./gameresults-1000-sims.json"
	end

	def startgame(simulation_mode = false)
		reset()
		if (!simulation_mode)
			Player.reset
			@playermode = chooseplayermode()
			return if @playermode == 0
			@player = getplayernames(@playermode)
			gameloop(self)
		else
			@player = getplayernames(1)
			gameloopsim(self)
		end
	end

	def players
		@player
	end

	def reset()
		@board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
		@moverecord = MoveRecord.new(@filename)
		@board_display = displayboard()
		
	end

	def entermove(coord, val)
		drow,dcol = arraytodisplayparser(coord)
		board[coord[0]][coord[1]] = val
		board_display[drow][dcol] = ['O','X'][val]
		showboard(self)
	end

	def get(row, col)
		board[row][col]
	end

	def load()
		prompt = TTY::Prompt.new(symbols: {marker: " "})
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
		request = prompt.select("Choose which game to display: ".center(100), linesUUIDs, show_help: :never, cycle: true)
		moves = lines[request]["Moves"]
		movesarray = []
		moves.each.with_index { |move,i| movesarray.push (i % 2 == 0) ? [arraytocommandsparser(move, @commands).join,""] : ["",arraytocommandsparser(move, @commands).join] }
		movesarray.push(["--------","--------"])
		movesarray.push(["Winner: ",lines[request]["Winner"]])
		table = TTY::Table.new(lines[request]["Players"], movesarray)
		table.render(:ascii).split("\n").each { |table_line| puts table_line.center(90) }
		file.close
	end
end