lines = File.readlines("day5.txt").map(&:chomp)

Seat = Struct.new(:line, :row, :col) do
  def inspect
    "#{line}: row #{row}, column #{col}, seat ID #{seat_id}"
  end

  def seat_id
    row * 8 + col
  end
end

class Range
  def mid
    (max+min) / 2
  end
end

def decode(line)
  row = 0..127
  col = 0..7

  
  line[0..6].chars.each do |part|
    case part
    when "F"
      row = row.min..(row.mid)
    when "B"
      row = (row.mid+1)..row.max
    else
      raise "cannot handle #{part}"
    end
  end

  raise "could not decode #{line} with final row #{row}" unless row.min == row.max

  line[7..].chars.each do |part|
    case part
    when "L"
      col = col.min..(col.mid)
    when "R"
      col = (col.mid+1)..col.max
    else
      raise "cannot handle #{part}"
    end
  end

  raise "could not decode #{line} with final col #{col}" unless col.min == col.max

  row  = row.min
  col  = col.min

  return Seat.new(
    line,
    row,
    col,
  )
end

lines.each do |line|
  puts decode(line).inspect
end