require_relative "../views/game-display.rb"
require_relative "./game-loop.rb"
require "uuid"
require "json"
require "tty-table"

#############################################################################
# The Player class initialises the player
#############################################################################
class Player
	attr_accessor :name, :val, :str

	PLAYERS = []

	def initialize(name, val=-1, str="")
		@name = name
		@val = val
		@str = str
		PLAYERS << self
	end

	def self.find(val)
		PLAYERS.detect { |player| player.val == val }
	end

	def self.names
		[Player.find(1).name + ": " + Player.find(1).str, Player.find(0).name + ": " +Player.find(0).str]
	end

	def setval(val)
		@val = val
		@str = ['O','X'][val]
	end

	def self.reset
		PLAYERS.clear
	end
end

#############################################################################
# The MoveRecord module creates a record of moves to save to a JSON file
#############################################################################  
class MoveRecord
	attr_reader :filename, :record

	def initialize(filename = "./gameresults.json")
		uuid = UUID.new
		@record = {"UUID": uuid.generate, "Players": [], "Moves": [], "Winner": nil}
		@filename = filename
	end

	def setplayers(players)
		@record[:Players] = players
	end

	def setwinner(player)
		@record[:Winner] = player
	end

	def push(move)
		@record[:Moves].push(move)
	end

	def length
		@record[:Moves].length
	end

	def to_s
		@record.to_s
	end
end
  
#############################################################################
# The Game class that creates a new instance of the game every time
#############################################################################
class Game
	attr_accessor :moverecord
	attr_reader :commands, :playermode, :player, :board, :board_display, :filename
	
	def initialize
		reset()
		@commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2}
		@filename = "./gameresults.json"
	end

	def startgame(simulation_mode = false)
		reset()
		if (!simulation_mode)
			Player.reset
			@playermode = chooseplayermode()
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
			eachline = JSON.parse(line)
			lines << eachline
			linesUUIDs << {"Game ID: " + eachline["UUID"][0..7].to_s => i}
		 nlines += 1
		end
		puts "\n Total number of games to load from: #{nlines}"
		puts "\n"
		puts ""
		request = prompt.select("Choose which game to display: ".center(100), linesUUIDs, show_help: :never, cycle: true)
		moves = lines[request]["Moves"]
		newarray = []
		moves.each.with_index do |move,i|
			newarray.push (i % 2 == 0) ? [arraytocommandsparser(move, @commands).join,""] : ["",arraytocommandsparser(move, @commands).join]
		end
		newarray.push(["--------","--------"])
		newarray.push(["Winner: ",lines[request]["Winner"]])
		table = TTY::Table.new(lines[request]["Players"], newarray)
		puts table.render(:ascii)
		file.close
	end
end