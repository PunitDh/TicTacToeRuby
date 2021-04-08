class Board
	attr_reader :board, :board_display

	def initialize
		@board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
		@board_display = Views::Display::board()
	end

	####### Return a duplicate of the board array and preserve the board ############################################
	def array
		return @board.dup
	end

	####### Get the value on a particular square ####################################################################
	def get
		@board[row][val]
	end

	####### Set the value of a particular square ####################################################################
	def set(row, col, val)
		@board[row][col] = val
	end

	####### Check if board has been won ###########################################################################
	def checkwin()
		tmparray    = Array.new
		tmparray[0] = Array.new
		tmparray[1] = Array.new
	
		@board.map.with_index do |row,i|
			return @board.transpose[i].first if checkequal(@board.transpose[i])
			return @board[i].first if checkequal(@board[i])
			tmparray[0].push(@board[i][i])
			tmparray[1].push(@board[2-i][i])
		end
	
		return tmparray[0].first if checkequal(tmparray.first)
		return tmparray[1].first if checkequal(tmparray[1])
		return false
	end
	
	####### Check if an array has all the same values ############################################################
	def checkequal(array)
		return (array.compact.length == array.length and array.uniq.length == 1)
	end

	####### Check if draw #######################################################################################
	def checkdraw()
		return (@board.flatten.compact.length == @board.flatten.length)
	end

	####### Return a random empty square on the board ##########################################################
	def randomsquare()
		return findemptysquares().sample
	end

	####### Find all empty squares on board ###################################################################
	def findemptysquares()
		@board.map.with_index { |row,i| row.map.with_index { |cell,j| [i,j] if cell.nil? }}.flatten(1).compact
	end	
end