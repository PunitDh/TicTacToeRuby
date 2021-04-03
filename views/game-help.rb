#############################################################################
# A method that shows "Help" feature
#############################################################################
def showhelp(game)
	puts ("\n\t\t***************************************************************************" * 2)
	puts "\t\t***************************    INSTRUCTIONS    ****************************"
	# tmpgets
	puts "\n\t\tThis is the tic-tac-toe board..."
	showboard(game)
	# tmpgets

	print "\n\n\t\t\'X\' always goes first..."
	# return if (tmpgets.upcase == "S")

	print "\n\n\t\tWho gets \'X\' and who gets \'O\' is determined by a coin toss..."
	# return if (tmpgets.upcase == "S")

	print "\n\n\t\tYou play by giving the following text commands:\n\n\t\t\t \"A1\", \"A2\", \"A3\", \"B1\", \"B2\", \"B3\", \"C1\", \"C2\", \"C3\"."
	# return if (tmpgets.upcase == "S")

	print "\n\n\t\tYou can enter the text command \"H\" for Help if you get stuck or lost..."
	# return if (tmpgets.upcase == "S")

	print "\n\n\t\tPress Ctrl+C or Cmd+C to exit the game at any time..."
	tmpgets
end

#############################################################################
# Show title prompts
#############################################################################
def showtitleprompts()
	print "\n\n\t\tLet's get started."
	return if (tmpgets.upcase == "S")

	print "\n\n\t\t\'X\' always goes first..."
	return if (tmpgets.upcase == "S")

	print "\n\n\t\tWho gets \'X\' and who gets \'O\' is determined by a coin toss..."
	return if (tmpgets.upcase == "S")

	print "\n\n\t\tYou play by giving the following text commands:\n\n\t\t\t \"A1\", \"A2\", \"A3\", \"B1\", \"B2\", \"B3\", \"C1\", \"C2\", \"C3\"."
	return if (tmpgets.upcase == "S")

	print "\n\t\tYou can enter the text command \"H\" for Help if you get stuck or lost..."
	return if (tmpgets.upcase == "S")

	print "\n\t\tPress Ctrl+C or Cmd+C to exit the game at any time..."
end