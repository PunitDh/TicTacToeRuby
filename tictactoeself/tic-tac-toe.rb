require "./init.rb"
require "./parser.rb"
require "./artificial-intelligence.rb"
require "./game-play.rb"
require "./game-end.rb"

####################################################################################
##########################         START THE GAME         ##########################
####################################################################################

## For future projects
# f = File.open("./gameresults.txt", "r")
# f.each_line do |line|
#   puts line
# end
# f.close

game = createnewgame()
nextplayer = cointoss(game[:player])
game[:moverecord].push(game[:player])
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