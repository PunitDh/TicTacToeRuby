require "./game_end.rb"
require "./init.rb"
require "./parser.rb"
require "./artificial-intelligence.rb"
require "./game-play.rb"

####################################################################################
##########################         START THE GAME         ##########################
####################################################################################

game = createnewgame()
nextplayer = cointoss(game[:player])

showboard(game)

# Game loop
begin
  nextplayer = nextgameplayer?(game, nextplayer) ? computermove(game, nextplayer) : playermove(game, nextplayer)
end while not (checkgameover(game))

# Game end state
endgame(game)

# COMPUTER VS COMPUTER
# begin
#   nextplayer = playmove(game,nextplayer)
#   break if (checkgameover(game))
# end while not (checkgameover(game))