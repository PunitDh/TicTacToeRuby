rows = [
    [nil, nil, nil],
    [nil, nil, nil],
    [nil, nil, nil]
]

# Print the board
board = rows.map do |row|
    display_row = row.map do |cell|
        cell.nil? ? ' ' : cell
        # cell ? cell : ' '
        # cell or " "
        # cell || " "
    end

    display_row.join('|')
end

puts board.join("\n" + ('-' * 5) + "\n")

print "Player x move: "
coordinates = gets.chomp.split(',')
coordinates = coordinates.map do |value|
    value = value.strip
    value.to_i - 1
end

x = coordinates[0]
y = coordinates[1]

if rows[y][x].nil?
    rows[y][x] = 'x'
end

# Print the board
board = rows.map do |row|
    display_row = row.map do |cell|
        cell.nil? ? ' ' : cell
        # cell ? cell : ' '
        # cell or " "
        # cell || " "
    end

    display_row.join('|')
end

puts board.join("\n" + ('-' * 5) + "\n")

# ---

print "Player o move: "
coordinates = gets.chomp.split(',')
coordinates = coordinates.map do |value|
    value = value.strip
    value.to_i - 1
end

x = coordinates[0]
y = coordinates[1]

if rows[y][x].nil?
    rows[y][x] = 'o'
end

# Print the board
board = rows.map do |row|
    display_row = row.map do |cell|
        cell.nil? ? ' ' : cell
        # cell ? cell : ' '
        # cell or " "
        # cell || " "
    end

    display_row.join('|')
end

puts board.join("\n" + ('-' * 5) + "\n")
