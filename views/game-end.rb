#############################################################################
# A method that ends the game
#############################################################################
def endgame(game)
  winner = checkwin(game.board)
  puts "\n\n"
  if (winner)
    winnername = Player.find(winner)
    game.moverecord.setwinner(winnername.name + ": " + ['O','X'][winner])

    if game.playermode == 1
      puts "\t\t\t\t\t╔" + "═"*25 +"╗"
      puts "\t\t\t\t\t║        You lose!        ║"
      puts "\t\t\t\t\t╚" + "═"*25 +"╝"
    else
      puts "\t\t\t\t\t╔═════" + "═"*(winnername.name.length+5) + "══════╗"
      puts "\t\t\t\t\t║     #{winnername.name} won!      ║"
      puts "\t\t\t\t\t╚═════" + "═"*(winnername.name.length+5) + "══════╝"
    end
  elsif (checkdraw(game.board))
    puts "\t\t\t\t\t╔" + "═"*25 +"╗"
    puts "\t\t\t\t\t║     Game is a draw!     ║"
    puts "\t\t\t\t\t╚" + "═"*25 +"╝"

    game.moverecord.setwinner("Draw")
  end
  puts "\n\n\t\tResults automatically saved to #{game.moverecord.filename}\n\n\n"
  File.write(game.moverecord.filename,(game.moverecord.record).to_json + "\n", mode: 'a')
end