module Views
	module GameHelp
		$version = 1.5
		$gamename = "Unbeatable TicTacToe"
		
		#############################################################################
		# A method that shows "Help" feature
		#############################################################################
		def self.showhelp()
			puts File.read(File.open("./lib/helpfile.hlp"))
			Views::Prompts::tmpgets
		end
		
		def self.showversion()
			puts "\n" + $gamename + "\t" + $version.to_s + "\n"
		end	
	end
end