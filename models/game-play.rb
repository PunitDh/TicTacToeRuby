#############################################################################
# A method to let the player play the next move
#############################################################################
def playermove(game, currentplayer)
  begin
    print "\n\t\t#{currentplayer.name}, please enter a command (or \"H\" for Help): "
    command = gets.chomp.strip.upcase.delete(' ')
    puts "\n\t\tYou (#{currentplayer.str}) entered: \"#{command}\""
    cmd_parse = validatecommand(game, command)
  end while not cmd_parse
  game.moverecord.push(cmd_parse)
  game.entermove(cmd_parse,currentplayer.val)
  currentplayer = Player.find(swapval(currentplayer.val))
end

#############################################################################
# A method to let the next player play, returns "nextplayer"
#############################################################################
def nextgameplayer?(game, nextplayer)
  return ((game.playermode == 1) and (nextplayer == game.players[1]))
end