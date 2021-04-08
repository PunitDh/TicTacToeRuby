require_relative "../models/Game.rb"
require_relative "../views/GameHelp.rb"

module GameController
	@game = Game.new

	def self.create
		@game.startgame()
	end

	def self.simulation
		@game.startgame(true)
	end

	def self.instructions
		Views::GameHelp::showhelp()
	end

	def self.load_games
		@game.load()
	end
end