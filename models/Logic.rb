module Logic
	
	####### Check if board has been won and return the winner ###############################################
	def self.checkwin(board)
		tmparray    = Array.new
		tmparray[0] = Array.new
		tmparray[1] = Array.new
	
		board.map.with_index do |row,i|
		return board.transpose[i].first if Logic::checkequal(board.transpose[i])
		return board[i].first if Logic::checkequal(board[i])
		tmparray[0].push(board[i][i])
		tmparray[1].push(board[2-i][i])
		end
	
		return tmparray[0].first if Logic::checkequal(tmparray.first)
		return tmparray[1].first if Logic::checkequal(tmparray[1])
		return false
	end
	
	####### Check if all elements in an array are equal ####################################################
	def self.checkequal(array)
		return (array.compact.length == array.length and array.uniq.length == 1)
	end
	
	##### Check if board is in a draw state ################################################################
	def self.checkdraw(board)
		return (board.flatten.compact.length == board.flatten.length)
	end
end