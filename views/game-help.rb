$version = 1.5
$gamename = "Unbeatable TicTacToe"

#############################################################################
# A method that shows "Help" feature
#############################################################################
def showhelp()
	puts File.read(File.open("./lib/helpfile.hlp"))
end

def showversion()
	puts "\n" + $gamename + "\t" + $version.to_s + "\n"
end