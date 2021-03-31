class Player
  attr_accessor :name, :val, :str

  PLAYERS = []

  def initialize(name, val=-1, str="")
    @name = name
    @val = val
    @str = str
    PLAYERS << self
  end

  # def val= (val)
  #   @val = val
  # end

  # def str= (str)
  #   @str = str
  # end

  # def name
  #   @name
  # end

  def self.find(val)
    PLAYERS.detect { |player| player.val == val }
  end

  # def str
  #   @str
  # end

  # def val
  #   @val
  # end
end

class MoveRecord
  attr_accessor :playernames, :move

  def initialize
    @recordarray = Array.new
  end
  
  def push(value)
    @recordarray.push(value)
  end

  def length
    @recordarray.length
  end

  def to_s
    @recordarray.to_s
  end
end




class Board
  attr_accessor :board, :board_display

  @board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
  def initialize(board=@board)
    # if (board == nil)
    #   @board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
    # else
    #   @board = board.dup
    # end
    @board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
    @board_display = displayboard()
    showtitlescreen(@board_display)
  end

  def length
    @board.flatten.length
  end

  def flatten
    @board.flatten
  end

  def get(val0, val1)
    @board[val0][val1]
  end

  #############################################################################
  # A method to check win states and returns the winner
  #############################################################################
  def checkwin(board=@board)
    tmparray = Array.new
    tmparray[0] = Array.new
    tmparray[1] = Array.new

    board.map.with_index do |row,i|
      return board.transpose[i].first if checkequal(board.transpose[i])
      return board[i].first if checkequal(board[i])
      tmparray[0].push(board[i][i])
      tmparray[1].push(board[2-i][i])
    end

    return tmparray[0][0] if checkequal(tmparray.first)
    return tmparray[1][0] if checkequal(tmparray[1])
    return false
  end
  
  #############################################################################
  # A method to check draw states
  #############################################################################
  def checkdraw(board=@board)
    return (board.flatten.compact.length == 9)
  end

  def set(row, column, val)
    drow, dcol = arraytodisplayparser([row,column])
    @board[row][column] = val
    @board_display[drow][dcol] = valtostr(val)
  end

  #############################################################################
  # A method to draw the board
  #############################################################################
  def show
    @board_display.map.with_index do |row,i|
      puts "\t\t\t\t\t" + @board_display[i]
    end
  end

  def computerpredictwin(val)
    # Check for an empty square
    emptysquares = findemptysquares()
    tmpboard = Array.new
    emptysquares.map do |empty|
      tmpboard = @board.map { |row| row.map { |cell| cell } }
      tmpboard[empty[0]][empty[1]] = val
      return empty if checkwin(tmpboard)
    end
    return false
  end

  # def map

  # end

  # def with_index
    
  # end

  ################################################################################################
  # The minimax recursion function
  ################################################################################################
  def minimax(val, maximising_player = true)
    tmpboard = Board.new
    best_move = {"r":nil, "c":nil, "score":0}
    
    if (checkwin())#checkwin(board))
        best_move[:score] = maximising_player ? -1 : 1
      return best_move
    elsif (checkdraw())#(board))
      best_move[:score] = 0
      return best_move
    end

    best_move[:score] = maximising_player ? -2 : 2

    board.map.with_index do |row,i|
      row.map.with_index do |cell,j|
        if cell.nil?
          tmpboard = board.map { |row| row.map { |cell| cell } }
          tmpboard[i][j] = val
          
          board_state = minimax(tmpboard, otherval(val), !maximising_player)
          $foo += 1
          
          if (maximising_player)
            if (board_state[:score] > best_move[:score])
              best_move[:score] = board_state[:score]
              best_move[:r] = i
              best_move[:c] = j
            end
          else
            if (board_state[:score] < best_move[:score])
              best_move[:score] = board_state[:score]
              best_move[:r] = i
              best_move[:c] = j            
            end
          end
          tmpboard = board.map { |row| row.map { |cell| cell } }
        end
      end
    end
    return best_move
  end

  def findemptysquares
    @board.map.with_index { |row,i| row.map.with_index { |cell,j| [i,j] if cell.nil? }}.flatten(1).compact
  end

  def valtostr(val)
    case val
      when 0
        return 'O'
      when 1
        return 'X'
    end
  end

  def grid
    @board
  end
end

#############################################################################
# A Game class
#############################################################################
class Game
  attr_accessor :board, :moverecord, :board_display
  attr_reader :commands, :playermode, :player

  def initialize
    @board = Board.new # [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
    @commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2}
    @moverecord = MoveRecord.new
    #@board_display = displayboard()
    #showtitlescreen(board_display)
    @playermode = chooseplayermode()
    @player = getplayernames(@playermode)
  end

  def playermode
    @playermode
  end

  def playernames
    [@player[0].name,@player[1].name]
  end

  def players
    @player
  end

  def board
    @board
  end

  # def boardvals(val0, val1)
  #   @board[val0][val1]
  # end

  def commands
    @commands
  end

  def moverecord
    @moverecord
  end

  def board_display
    @board_display
  end
end



#############################################################################
# A method used to choose the player mode
#############################################################################
def chooseplayermode()
  begin
    print "\n\t\tChoose (1)-player or (2)-player mode: "
    playermodeget = gets.chomp
    playermode = playermodeget.to_i
    if (playermodeget.length == 0)
      playermode = 1
      puts "\n\t\tAutomatically selecting (1)-player mode...\n"
      break
    elsif ([1,2].index(playermode).nil?)
      puts "\n\t\t\"#{playermodeget}\" is not a valid player mode. Enter 1 or 2:\n"
    end
  end while not ([1,2].index(playermode) or playermodeget.length == 0)
  return playermode
end


#############################################################################
# A method to get the player names and save them in a hash
#############################################################################
def getplayernames(playermode)
  player = Array.new    # Set default values below
  player[0] = Player.new("Player 1")
  player[1] = Player.new("Player 2")

  # Get player names
  for i in 0..playermode-1
    getname(player[i], i)
    player[1].name = (playermode == 1) ? "Computer" : next
  end

  # Welcome the players
    print (playermode == 1) ? "\n\n\t\tWelcome #{player[0].name}!" : "\n\n\t\tWelcome #{player[0].name} and #{player[1].name}!"
  tmpgets
  # print "These are the players: \n"
  # p player
  return player
end

#############################################################################
# A method to get the player names
#############################################################################
def getname(player, index)
  print "\n\t\tEnter #{player.name} Name: "
  name = gets.chomp
  player.name = (name.length == 0) ? "Player #{index+1}" : name
end

#################################################################################
# A method used to generate a cointoss, assign X and O, and choose first player
#################################################################################
def cointoss(player)
  # Coin toss
  print "\n\n\t\tTossing coin now...(Press ENTER to see coin toss results)"
  tmpgets

  # Generate a random value
  randtoss = (rand()*2)

  # Display the coin toss
  ctoss = (randtoss < 0.95) ? "T" : "H"
  player[0].str = (randtoss < 1) ? "O" : "X"
  player[0].val = (randtoss < 1) ? 0 : 1
  player[1].str = (randtoss < 1) ? "X" : "O"
  player[1].val = (randtoss < 1) ? 1 : 0

  puts "\n\t\tThe result of the coin toss is: \n\n"
  puts "\t\t\t\t\t\t\t  -------  "
  puts "\t\t\t\t\t\t\t/         \\"
  puts "\t\t\t\t\t\t\t|    #{ctoss}    |"
  puts "\t\t\t\t\t\t\t\\         /"
  print "\t\t\t\t\t\t\t  -------- "

  tmpgets

  # Set current player based on who has X or O
  currentplayer = (player[1].val == 1) ? player[1] : player[0]
  puts "\n\t\t#{player[0].name} is \'#{player[0].str}\'. #{player[1].name} is \'#{player[1].str}\'.\n\n"
  print "\t\t#{currentplayer.name} goes first..."
  tmpgets

  return currentplayer
end

#############################################################################
# A method used to generate the board display
#############################################################################
def displayboard()

  board_display = ["     1   2   3  ",
    "   |---|---|---|",
    " A |   |   |   |",
    "   |---|---|---|",
    " B |   |   |   |",
    "   |---|---|---|",
    " C |   |   |   |",
    "   |---|---|---|"]

    return board_display
end

#############################################################################
# A method that shows "Help" feature
#############################################################################
def showhelp(game)
  puts ("\n\t\t***************************************************************************" * 5)
  puts "\t\t*******************************    HELP    ********************************"
  puts "\n\t\tThis is the tic-tac-toe board..."
  game.board.show()
  puts "\n\n\t\tEnter the following text commands: \n\n\t\t\t\"A1\", \"A2\", \"A3\", \"B1\", \"B2\", \"B3\", \"C1\", \"C2\", \"C3\".\n\n\t\tThey correspond to each cell on the board..."
  puts "\n\t\t\"R\" to play a random move"
  puts "\n\t\tPress Ctrl+C or Cmd+C to exit the game at any time"
end
  
#############################################################################
# A debug method used to draw a simpler version of the board
#############################################################################
def showsimpleboard(board)
  print "\n"
  print "\t\t|---------------| \n"
  board.map do |row|
    print "\t\t"
    row.map do |cell|
      print cell.nil? ? "|    " : "|  " + cell.to_s + " "
    end
    print " |\n"
    print "\t\t|---------------| \n"
  end
end

#############################################################################
# A method used to get a 'nil' user input
#############################################################################
def tmpgets
  tmp = gets.chomp
end

#############################################################################
# A method to print the title screen
#############################################################################
def showtitlescreen(board_display)
  # Title Screen
  puts "\n\n\n\t\t*****************************************************************************"
  puts "\t\t*                                                                           *"
  puts "\t\t*            Welcome to UNBEATABLE TIC-TAC-TOE V1.2 by Punit Dh             *"
  puts "\t\t*                                                                           *"
  puts "\t\t*****************************************************************************\n\n\n\n"
  board_display.map.with_index do |row,i|
    puts "\t\t\t\t\t" + board_display[i]
  end
  print "\n\n\n\n\t\t\t\tPress ENTER or RETURN to START THE GAME\n\n\t\t\t\tType \"S\" to skip the intro at any time"
  return if (tmpgets.upcase == "S")

  print "\n\n\t\tWelcome to UNBEATABLE TIC-TAC-TOE...\n\n\t\tThis version of TIC-TAC-TOE uses the MINIMAX algorithm to find the best move..."
  return if (tmpgets.upcase == "S")

  print "\n\n\t\tIn other words, it is unbeatable..."
  return if (tmpgets.upcase == "S")

  print "\n\n\t\tGROUND RULES:"
  return if (tmpgets.upcase == "S")

  print "\n\n\t\t\'X\' always goes first..."
  return if (tmpgets.upcase == "S")

  print "\n\n\t\tWho gets \'X\' and who gets \'O\' is determined by a coin toss..."
  return if (tmpgets.upcase == "S")

  print "\n\n\t\tYou play by giving the following text commands:\n\n\t\t\t \"A1\", \"A2\", \"A3\", \"B1\", \"B2\", \"B3\", \"C1\", \"C2\", \"C3\"."#\n\n\t\tThey correspond to each cell on the board..."
  return if (tmpgets.upcase == "S")

  print "\n\t\tYou can enter the text command \"H\" for Help if you get stuck or lost..."
  return if (tmpgets.upcase == "S")

  print "\n\t\tPress Ctrl+C or Cmd+C to exit the game at any time..."
  return if (tmpgets.upcase == "S")

  print "\n\n\t\tLet's get started..."
  return if (tmpgets.upcase == "S")
end