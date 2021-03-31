#############################################################################
# A debug method used to draw a simpler version of the board
#############################################################################
def showtitleprompts()
	print "\n\n\t\tLet's get started."
	return if (tmpgets.upcase == "S")

	# print "\n\n\t\tGROUND RULES: (Type \"S\" to skip)"
	# return if (tmpgets.upcase == "S")
  
	print "\n\n\t\t\'X\' always goes first..."
	return if (tmpgets.upcase == "S")
  
	print "\n\n\t\tWho gets \'X\' and who gets \'O\' is determined by a coin toss..."
	return if (tmpgets.upcase == "S")
  
	print "\n\n\t\tYou play by giving the following text commands:\n\n\t\t\t \"A1\", \"A2\", \"A3\", \"B1\", \"B2\", \"B3\", \"C1\", \"C2\", \"C3\"."#\n\n\t\tThey correspond to each cell on the board..."
	return if (tmpgets.upcase == "S")
  
	print "\n\t\tYou can enter the text command \"H\" for Help if you get stuck or lost..."
	return if (tmpgets.upcase == "S")
  
	print "\n\t\tPress Ctrl+C or Cmd+C to exit the game at any time..."
  end