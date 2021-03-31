require_relative "./game-parser.rb"
require_relative "./artificial-intelligence.rb"
require_relative "./game-play.rb"
require_relative "../views/game-end.rb"
require_relative "./game-logic.rb"
require_relative "../views/game-title.rb"

####################################################################################
##########################         START THE GAME         ##########################
####################################################################################

def game_loop(game)
  nextplayer = cointoss(game.players)
  game.moverecord.push(game.playernames)
  showboard(game)

  # Game loop
  begin
    nextplayer = nextgameplayer?(game, nextplayer) ? computermove(game, nextplayer) : playermove(game, nextplayer)
  end while not (checkgameover(game))

  # Game end state
  endgame(game)

  # #TO PLAY COMPUTER VS COMPUTER SIMULATIONS, RUN THIS LOOP INSTEAD OF THE GAME LOOP
  # begin
  #   nextplayer = computermove(game,nextplayer)
  #   # break if (checkgameover(game))
  # end while not (checkgameover(game))
  # endgame(game)
end

