require_relative "../models/game-classes.rb"
require_relative "../views/game-help.rb"

module GameController
	@game = Game.new

	def self.create
		@game.startgame()
	end

	def self.simulation
		@game.startgame(true)
	end

	def self.instructions
		showhelp()
		tmpgets
	end

	def self.load_games
		@game.load()
	end
end