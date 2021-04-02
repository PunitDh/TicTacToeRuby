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

	def initialize(simulation_mode = false)
		board_reset()
		@commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2}
		if (!simulation_mode)
			@playermode = chooseplayermode()
			@player = getplayernames(@playermode)
			showtitleprompts()
			gameloop(self)
		else
			@player = getplayernames(1)
			gameloopsim(self)
		end
	end

	def playernames
		pl = []
		pl[0] = Player.find(1)
		pl[1] = Player.find(0)
		[pl[0].name + ": " + pl[0].str, pl[1].name + ": " + pl[1].str]
	end

	def players
		@player
	end

	def board_reset()
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