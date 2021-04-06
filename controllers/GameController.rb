require_relative "../models/game-classes.rb"
require_relative "../views/game-help.rb"
require_relative "../views/game-load.rb"

module GameController
	@game = Game.new

	def self.create
		@game.startgame()
	end

	def self.simulation
		@game.startgame(true)
	end

	def self.instructions
		showhelp(@game)
	end

	def self.load_games
		load_games()
	end
end