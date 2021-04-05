require_relative "../views/game-display.rb"
require_relative "./game-loop.rb"

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
	def initialize
		@record = {"Players": [], "Moves": [], "Winner": nil}
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
	attr_reader :commands, :playermode, :player, :board, :board_display

	def initialize
		reset()
		@commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2}
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
		@moverecord = MoveRecord.new
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
end