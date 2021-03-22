#############################################################################
# A method to let the player play the next move
#############################################################################
def playermove(game, currentplayer)
  begin
    print "\n\t\t#{currentplayer[:name]}, please enter a command: "
    command = gets.chomp.upcase
    puts "\n\t\tYou (#{currentplayer[:str]}) entered: \"#{command}\""
    cmd_parse = validatecommand(game, command)
  end while not cmd_parse
  game[:moverecord].push(cmd_parse)
  currentplayer = entermove(game, currentplayer, cmd_parse)
end

#############################################################################
# A method to check if the entered command is valid
#############################################################################
def entermove(game, currentplayer, cmd_parse)
  display_parse = arraytodisplayparser(cmd_parse)
  game[:board][cmd_parse[0]][cmd_parse[1]] = currentplayer[:val]
  game[:board_display][display_parse[0]][display_parse[1]] = currentplayer[:str]
  showboard(game)
  return swapturn(currentplayer, game[:player])
end

#############################################################################
# A method to check if the entered command is valid
#############################################################################
def nextgameplayer?(game, nextplayer)
  return ((game[:playermode] == 1) and (nextplayer == game[:player][1]))
end