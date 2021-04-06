require_relative "./game-parser.rb"
require_relative "./artificial-intelligence.rb"
require_relative "./game-play.rb"
require_relative "../views/game-end.rb"
require_relative "./game-logic.rb"


$foo    = 0       # A global variable used to store the number of iterations
$encmbr = 0       # A global variable for encumbrance percentage % (default: 0))

#############################################################################
# The main GAME LOOP
#############################################################################
def gameloop(game)
  nextplayer = selectfirstplayer(game.players)
  game.moverecord.setplayers(Player.names)
  showboard(game)

  # Game loop
  begin
    nextplayer = nextgameplayer?(game, nextplayer) ? computermove(game, nextplayer) : playermove(game, nextplayer)
  end while not (checkgameover(game))

  # Game end state
  endgame(game)
end

#############################################################################
# SIMULATION LOOP
#############################################################################
def gameloopsim(game)
  begin
    print "\n\t\tEnter number of simulations: "
    nsim = gets.chomp
    print "\t\t\"#{nsim}\" is not a valid number of simulations. Please enter a valid input.\n" if (nsim.to_i <= 0)
  end while (nsim.to_i <= 0)

  ([nsim.to_i,1000].min).times do # To prevent crashes, the max number of simulations is capped at 1000
    nextplayer = cointoss(game.players)[0]
    game.moverecord.setplayers(Player.names)
      
    begin
      nextplayer = computermove(game,nextplayer)  
    end while not (checkgameover(game))
    endgame(game)
    game.reset()
  end
end