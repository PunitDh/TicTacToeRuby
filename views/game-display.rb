#############################################################################
# A method to draw the board
#############################################################################
def showboard(game)
    game.board_display.map.with_index do |row,i|
      str = game.board_display[i].split("X").join("X".light_red)
      str = str.split("O").join("O".light_blue)
      puts "\t\t\t\t\t" + str
    end
end

#############################################################################
# A method used to generate the board display
#############################################################################
def displayboard()
	return board_display = ["     1   2   3  ",
		"   ┌───┬───┬───┐",
		" A │   │   │   │",
		"   ├───┼───┼───┤",
		" B │   │   │   │",
		"   ├───┼───┼───┤",
		" C │   │   │   │",
		"   └───┴───┴───┘"]
end

#############################################################################
# A method to get the player names and save them in a hash
#############################################################################
def getplayernames(playermode)
  player = Array.new    # Set default values below
  player[0] = Player.new("Player 1")
  player[1] = Player.new("Player 2")

  # Get player names
  for i in 0..playermode-1
    getname(player[i], i)
    player[1].name = (playermode == 1) ? "Computer" : next
  end

  # Welcome the players
    print (playermode == 1) ? "\n\n\t\tWelcome #{player[0].name}!" : "\n\n\t\tWelcome #{player[0].name} and #{player[1].name}!"
  tmpgets

  return player
end

#############################################################################
# A method to get the player names
#############################################################################
def getname(player, index)
  print "\n\t\tEnter #{player.name} Name: "
  name = gets.chomp
  player.name = (name.length == 0) ? "Player #{index+1}" : name
end

#################################################################################
# A method used to choose first player
#################################################################################
def selectfirstplayer(player)
  # Coin toss
  print "\n\n\t\tTossing coin now...(Press ENTER to see coin toss results)"
  tmpgets
  currentplayer = cointoss(player)
  puts "\n\t\tThe result of the coin toss is: \n\n"
  puts "\t\t\t\t\t\t\t  -------  "
  puts "\t\t\t\t\t\t\t/         \\"
  puts "\t\t\t\t\t\t\t|    #{currentplayer[1]}    |"
  puts "\t\t\t\t\t\t\t\\         /"
  print "\t\t\t\t\t\t\t  -------- "
  tmpgets

  puts "\n\t\t#{player[0].name} is \'#{player[0].str}\'. #{player[1].name} is \'#{player[1].str}\'.\n\n"
  print "\t\t#{currentplayer[0].name} goes first..."
  tmpgets

  return currentplayer[0]
end

#############################################################################
# A debug method used to draw a simpler version of the board
#############################################################################
def showsimpleboard(board)
  print "\n"
  print "\t\t|---------------| \n"
  board.map do |row|
    print "\t\t"
    row.map do |cell|
      print cell.nil? ? "|    " : "|  " + cell.to_s + " "
    end
    print " |\n"
    print "\t\t|---------------| \n"
  end
end