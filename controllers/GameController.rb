require_relative "../models/Game.rb"
require_relative "../views/GameInfo.rb"

module GameController
	@game = Game.new

	def self.create
		@game.startgame()
	end

	def self.simulation
		@game.startgame(true)
	end

	def self.instructions
		Views::GameInfo::showhelp()
	end

	def self.load_games
		@game.load()
	end
end