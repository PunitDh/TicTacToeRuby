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
		[Player.find(1).name + ": " + Player.find(1).str, Player.find(0).name + ": " + Player.find(0).str]
	end

	def requestname(index)
		print "\n\t\tEnter #{@name} Name: "
		@name = gets.chomp
		@name = (@name.length == 0) ? "Player #{index+1}" : @name
	end

	def setval(val)
		@val = val
		@str = ['O','X'][val]
	end

	def self.reset
		PLAYERS.clear
	end
end