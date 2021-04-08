###############################################################################################
# A method used to print a message inside a box
###############################################################################################
def printbox(message, width: 25, height: 3, border: :thick)
	box = (TTY::Box.frame message, width: width, height: height, border: border, align: :center).split("\n")
  box.each { |line| print line.center(100)+"\n" }
end

###############################################################################################
# A method used to print a message inside a box
###############################################################################################
def prompt(question, choices, halign: 95)
	prompt = TTY::Prompt.new(symbols: {marker: " "})
  return prompt.select("#{question}\n".center(halign), choices, show_help: :never, cycle: true)
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