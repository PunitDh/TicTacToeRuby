module AI

  ####### Spit out a computer response ###########################################################
  def self.response(board, val)
    emptysquares = findemptysquares(board)
    return randomsquare(emptysquares) if emptysquares.length == board.flatten.length or (($encmbr.nil?) ? nil : (rand() > ((100-$encmbr).to_f/100).to_f))
    $foo = 0
    [val,swapval(val)].each do |v|
      predictwin = AI::predictwin(board, emptysquares, v)
      return predictwin if predictwin
    end
    best_move = AI::minimax(board,val)
    return [best_move[:r], best_move[:c]]
  end

  ########### Predicts whether the next move is a win #############################################
  def self.predictwin(board, emptysquares, val)
    emptysquares.map do |empty|
      tmpboard = board.map { |row| row.map { |cell| cell } }
      tmpboard[empty[0]][empty[1]] = val
      return empty if Logic::checkwin(tmpboard)
    end
    return false
  end

  ################################################################################################
  # The minimax recursion function - The brain of the program
  ################################################################################################
  def self.minimax(board, val, maximising_player = true)
    best_move = {"r":nil, "c":nil, "score":0}
    
    if (Logic::checkwin(board))
        best_move[:score] = maximising_player ? -1 : 1
      return best_move
    elsif (Logic::checkdraw(board))
      best_move[:score] = 0
      return best_move
    end

    best_move[:score] = maximising_player ? -2 : 2
    board.map.with_index do |row,i|
      row.map.with_index do |cell,j|
        if cell.nil?
          tmpboard = board.map { |row| row.map { |cell| cell } }
          
          tmpboard[i][j] = val
          
          board_state = AI::minimax(tmpboard, swapval(val), !maximising_player)
          $foo += 1   # A global variable used to store the number of iterations
          
          if ((maximising_player and board_state[:score] > best_move[:score]) or (!maximising_player and board_state[:score] < best_move[:score]))
              best_move[:score] = board_state[:score]
              best_move[:r] = i
              best_move[:c] = j
          end
          tmpboard = board.map { |row| row.map { |cell| cell } }
        end
      end
    end
    return best_move
  end
end





##########  END OF MODULE *******************************

################################################################################################
# A method that spits out a random square
################################################################################################
def randomsquare(emptysquares)
  return emptysquares.sample
end


################################################################################################
# A method to check which squares are empty on the board
################################################################################################
def findemptysquares(board)
  board.map.with_index { |row,i| row.map.with_index { |cell,j| [i,j] if cell.nil? }}.flatten(1).compact
end

################################################################################################
# A method that returns the opponent's piece
################################################################################################
def swapval(val)
	1-val
end