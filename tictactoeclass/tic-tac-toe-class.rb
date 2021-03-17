require "./print_board.rb"
require "./player_move.rb"
require "./winner.rb"

rows = [
 [nil,nil,nil],
 [nil,nil,nil],
 [nil,nil,nil]
]

#-----------------------------------------------
#-----------------------------------------------
#--- START THE GAME-----------------------------
begin
    print_board(rows)
    player_move(rows, 'x')
    print_board(rows)
    player_move(rows, 'o') if not winner?(rows)
end while not winner?(rows)

# Finish
puts "X won"
print_board(rows)
