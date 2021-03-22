require "./print_board.rb"
require "./player_move.rb"
require "./winner.rb"

rows = [
 [nil,nil,nil],
 [nil,nil,nil],
 [nil,nil,nil]
]

winner = nil
#-----------------------------------------------
#-----------------------------------------------
#--- START THE GAME-----------------------------
begin
    print_board(rows)
    player_move(rows, 'x')
    print_board(rows)
    winner = winner?(rows)
    break if winner

    player_move(rows, 'o') if not winner?(rows)
    winner = winner?(rows)
end while not winner?(rows)

# Finish
puts "#{winner} is the winner!"
print_board(rows)
