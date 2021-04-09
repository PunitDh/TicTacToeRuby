module Views
	module Display
		def self.board()
			return [
			"     1   2   3  ",
				"   ┌───┬───┬───┐",
				" A │   │   │   │",
				"   ├───┼───┼───┤",
				" B │   │   │   │",
				"   ├───┼───┼───┤",
				" C │   │   │   │",
				"   └───┴───┴───┘"]
		end		
		
		###### Print a message inside a box #############################################################################
		def self.printbox(message, width: 25, height: 3, border: :thick)
			box = (TTY::Box.frame message, width: width, height: height, border: border, align: :center).split("\n")
			box.each { |line| print line.center(100)+"\n" }
		end

		###### Prints the title screen #################################################################################
		def self.titlescreen()
			# Title Screen
			title = ["\n",
			"╔" + "═"*75+"╗",
			"║" + " "*75+"║",
			"║            Welcome to...                                                  ║",
			"║                                                                           ║",
			"║         █  █ █▀▀▄ █▀▀▄ █▀▀ █▀▀█ ▀▀█▀▀ █▀▀█ █▀▀▄ █   █▀▀                   ║",
			"║         █  █ █  █ █▀▀▄ █▀▀ █▄▄█   █   █▄▄█ █▀▀▄ █   █▀▀                   ║",
			"║         ▀▄▄▀ ▀  ▀ ▀▀▀  ▀▀▀ ▀  ▀   ▀   ▀  ▀ ▀▀▀  ▀▀▀ ▀▀▀ 　                ║",
			"║                                                                           ║",
			"║        ▀▀█▀▀  ▀  █▀▀    ▀▀█▀▀ █▀▀█ █▀▀    ▀▀█▀▀ █▀▀█ █▀▀                  ║",
			"║          █   ▀█▀ █   ▀▀   █   █▄▄█ █   ▀▀   █   █  █ █▀▀                  ║",
			"║          █   ▀▀▀ ▀▀▀      █   ▀  ▀ ▀▀▀      █   ▀▀▀▀ ▀▀▀                  ║",
			"║                                                 Version "+$version.to_s+"               ║",
			"║                     "+"Created by Punit Dh".black.blink+"                                   ║",
			"║" + " "*75+"║",
			"╚" + "═"*75+"╝\n"]
			
			title.each { |line| puts "\t"*2 + line.red }
			
			Views::Display::board().each { |row| puts "\t\t\t\t\t" + row }
		end		

		# #############################################################################
		# # A debug method used to draw a simpler version of the board
		# #############################################################################
		# def self.showsimpleboard(board)
		# 	print "\n"
		# 	print "\t\t|---------------| \n"
		# 	board.map do |row|
		# 	print "\t\t"
		# 	row.map do |cell|
		# 		print cell.nil? ? "|    " : "|  " + cell.to_s + " "
		# 	end
		# 	print " |\n"
		# 	print "\t\t|---------------| \n"
		# 	end
		# end
	end
end