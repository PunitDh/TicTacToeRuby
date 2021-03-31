#############################################################################
# A method used to generate the board display
#############################################################################
def displayboard()
	# board_display = ["     1   2   3  ",
	# 	"   ╔═══╦═══╦═══╗",
	# 	" A ║   ║   ║   ║",
	# 	"   ╠═══╬═══╬═══╣",
	# 	" B ║   ║   ║   ║",
	# 	"   ╠═══╬═══╬═══╣",
	# 	" C ║   ║   ║   ║",
	# 	"   ╚═══╩═══╩═══╝"]

		board_display = ["     1   2   3  ",
		"   ┌───┬───┬───┐",
		" A │   │   │   │",
		"   ├───┼───┼───┤",
		" B │   │   │   │",
		"   ├───┼───┼───┤",
		" C │   │   │   │",
		"   └───┴───┴───┘"]		

	return board_display
end

  #############################################################################
# A method to print the title screen
#############################################################################
def showtitlescreen(board_display)
	# Title Screen
	title = "\n\n\n\t\t╔" + "═"*75+"╗
	\t║" + " "*75+"║
	\t║            Welcome to UNBEATABLE TIC-TAC-TOE V1.2 by Punit Dh             ║
	\t║" + " "*75+"║
	\t╚" + "═"*75+"╝\n\n\n\n"
	
	puts title#.red.blink
	board_display.map.with_index do |row,i|
		puts "\t\t\t\t\t" + board_display[i]
	end
	# print "\n\n\n\n\t\t\t\tPress ENTER or RETURN to START THE GAME\n\n\t\t\t\tType \"S\" to skip the intro at any time"
	# return if (tmpgets.upcase == "S")

	# print "\n\n\t\tWelcome to UNBEATABLE TIC-TAC-TOE...\n\n\t\tThis version of TIC-TAC-TOE uses the MINIMAX algorithm to find the best move..."
	# return if (tmpgets.upcase == "S")

	# print "\n\n\t\tIn other words, it is unbeatable..."
	# return if (tmpgets.upcase == "S")
end

#############################################################################
# A method used to get a 'nil' user input
#############################################################################
def tmpgets
	tmp = gets.chomp
  end