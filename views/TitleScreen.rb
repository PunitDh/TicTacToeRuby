module Views
	module TitleScreen
		def self.show()
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
			
			Views::DisplayBoard::board().each { |row| puts "\t\t\t\t\t" + row }
		end
	end
end