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
# A method used to choose the player mode
#############################################################################
def chooseplayermode()
	prompt = TTY::Prompt.new(symbols: {marker: " "})
	choices = {"\n\n\t\t\t\t\t   (1)-Player Mode": 1, "\n\t\t\t\t\t   (2)-Player Mode": 2}
	playermode = prompt.select("\n\n\t\t\t\t\tChoose (1)-player or (2)-player mode:", choices, show_help: :never)
	return playermode
end

#################################################################################
# A method used to generate a cointoss, assign X and O
#################################################################################
def cointoss(players)
	vals = ['O','X']
	ctoss = rand().round
	player[0].str, player[0].val = vals[ctoss], ctoss
	player[1].str, player[1].val = vals[otherval(ctoss)], otherval(ctoss)
	return [Player.find(1), ['T','H'][ctoss]]
end

#############################################################################
# A method to print the title screen
#############################################################################
def showtitlescreen(board_display)
	# Title Screen
	title = "\n
	\t╔" + "═"*75+"╗
	\t║" + " "*75+"║
	\t║            Welcome to...                                                  ║
	\t║                                                                           ║
	\t║         █  █ █▀▀▄ █▀▀▄ █▀▀ █▀▀█ ▀▀█▀▀ █▀▀█ █▀▀▄ █   █▀▀                   ║
	\t║         █  █ █  █ █▀▀▄ █▀▀ █▄▄█   █   █▄▄█ █▀▀▄ █   █▀▀                   ║
	\t║         ▀▄▄▀ ▀  ▀ ▀▀▀  ▀▀▀ ▀  ▀   ▀   ▀  ▀ ▀▀▀  ▀▀▀ ▀▀▀ 　                ║
	\t║                                                                           ║
	\t║        ▀▀█▀▀  ▀  █▀▀    ▀▀█▀▀ █▀▀█ █▀▀    ▀▀█▀▀ █▀▀█ █▀▀                  ║
	\t║          █   ▀█▀ █   ▀▀   █   █▄▄█ █   ▀▀   █   █  █ █▀▀                  ║
	\t║          █   ▀▀▀ ▀▀▀      █   ▀  ▀ ▀▀▀      █   ▀▀▀▀ ▀▀▀                  ║
	\t║                                                        V1.2               ║
	\t║                     "+"Created by Punit Dh".on_white.blink+"                                   ║
	\t║" + " "*75+"║
	\t╚" + "═"*75+"╝\n"
	
	puts title.red
	
	board_display.map.with_index do |row,i|
		puts "\t\t\t\t\t" + board_display[i]
	end
end

#############################################################################
# A method used to get a 'nil' user input
#############################################################################
def tmpgets
	tmp = gets.chomp
end