require_relative "../models/game-classes.rb"

module GameController
	def self.create
		game = Game.new	
	end

	def self.simulation
		game = Game.new(true)
	end
end