# frozen_string_literal: true

require_relative '../models/game'
require_relative '../views/game_info'

module GameController
  @game = Game.new

  def self.create
    @game.startgame
  end

  def self.simulation
    @game.startgame(true)
  end

  def self.instructions
    Views::GameInfo.showhelp
  end

  def self.load_games
    @game.load
  end
end
