module Views
	module GameInfo
		$version = 1.5
		$gamename = "Unbeatable TicTacToe"
		
		##### Shows "Help" feature #########################################################################
		def self.showhelp()
			puts File.read(File.open("./lib/helpfile.hlp"))
			Views::Prompts::tmpgets
		end

		##### Show the version of the game #################################################################
		def self.showversion()
			puts "\n" + $gamename + "\t" + $version.to_s + "\n"
		end	

		##### Shows some game information #################################################################
		def self.showabout()
			puts File.read(File.open("./lib/about.hlp"))
			Views::Prompts::tmpgets
		end
	end
end