#############################################################################
# A method used to choose the player mode
#############################################################################
def chooseplayermode()
	prompt = TTY::Prompt.new(symbols: {marker: " "})
	choices = {"\n\n\t\t\t\t\t   (1)-Player Mode": 1, "\n\t\t\t\t\t   (2)-Player Mode": 2}
	return prompt.select("\n\n\t\t\t\t\tChoose (1)-player or (2)-player mode:", choices, show_help: :never)
end

#################################################################################
# A method used to generate a cointoss, assign X and O
#################################################################################
def cointoss(players)
	ctoss = rand().round
	players.each do |player|
		ctoss = swapval(ctoss)
		player.setval(ctoss)
	end
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