#################################################################################
# A method used to generate a cointoss, assign X and O
#################################################################################
def cointoss(players)
	ctoss = rand().round
	players.each do |player|
		player.setval(ctoss)
		ctoss = swapval(ctoss)
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
	\t║                                                 Version "+$version.to_s+"               ║
	\t║                     "+"Created by Punit Dh".black.blink+"                                   ║
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
	tmp = $stdin.gets
end