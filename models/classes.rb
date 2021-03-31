require_relative "../views/game-prompts.rb"
require_relative "../views/game-init.rb"
require_relative "./game-loop.rb"

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
  
  class MoveRecord
	attr_accessor :playernames, :move
  
	def initialize
	  @recordarray = Array.new
	end
	
	def push(value)
	  @recordarray.push(value)
	end
  
	def length
	  @recordarray.length
	end
  
	def to_s
	  @recordarray.to_s
	end
  end
  
  #############################################################################
  # A Game class
  #############################################################################
  class Game
	attr_accessor :moverecord, :board_display
	attr_reader :commands, :playermode, :player, :board
  
	# board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
	def initialize()
	  @board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
	  @commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2}
	  @moverecord = MoveRecord.new
	  @board_display = displayboard()
	#   showtitlescreen(board_display)
	#   showtitleprompts()
	  @playermode = chooseplayermode()
	  @player = getplayernames(@playermode)
	  showtitleprompts()
	  game_loop(self)
	end
  
	def playernames
	  [@player[0].name,@player[1].name]
	end
  
	def players
	  @player
	end
  
	def playmove(coord, val)
	  drow,dcol = arraytodisplayparser(coord)
	  board[coord[0]][coord[1]] = val
	  @board_display[drow][dcol] = valtostr(val)
	  showboard(self)
	end
  
	def get(row, col)
	  board[row][col]
	end
  
	def valtostr(val)
	  case val
		when 0
		  return 'O'
		when 1
		  return 'X'
	  end
	end
  end