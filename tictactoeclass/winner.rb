def winner?(rows)
    winner_row?(rows.first)
end

def winner_row?(row)
    compacted_length = row.compact.length
    unique_length = row.uniq.length
    (compacted_length == 3) && (unique_length == 1)
end