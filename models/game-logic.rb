#############################################################################
# A method to check win states and returns the winner
#############################################################################
def checkwin(board)
	tmparray    = Array.new
	tmparray[0] = Array.new
	tmparray[1] = Array.new
  
	board.map.with_index do |row,i|
	  return board.transpose[i].first if checkequal(board.transpose[i])
	  return board[i].first if checkequal(board[i])
	  tmparray[0].push(board[i][i])
	  tmparray[1].push(board[2-i][i])
	end
  
	return tmparray[0].first if checkequal(tmparray.first)
	return tmparray[1].first if checkequal(tmparray[1])
	return false
end
  
#############################################################################
# A method to check if all elements in an array are equal
#############################################################################
def checkequal(array)
	return (array.compact.length == array.length and array.uniq.length == 1) #? array.uniq[0] : false
end

#############################################################################
# A method to check draw states
#############################################################################
def checkdraw(board)
	return (board.flatten.compact.length == board.flatten.length)
end