# frozen_string_literal: true

lines = File.readlines('day5.txt').map(&:chomp)

Seat = Struct.new(:line, :row, :col) do
  def inspect
    "#{line}: row #{row}, column #{col}, seat ID #{seat_id}"
  end

  def seat_id
    row * 8 + col
  end
end

BoardingPass = Struct.new(:line) do
  def seat
    @seat ||= begin
      row = 0..127
      col = 0..7

      line[0..6].chars.each do |part|
        case part
        when 'F'
          row = row.min..(row.mid)
        when 'B'
          row = (row.mid + 1)..row.max
        else
          raise "cannot handle #{part}"
        end
      end

      raise "could not decode #{line} with final row #{row}" unless row.min == row.max

      line[7..9].chars.each do |part|
        case part
        when 'L'
          col = col.min..(col.mid)
        when 'R'
          col = (col.mid + 1)..col.max
        else
          raise "cannot handle #{part}"
        end
      end

      raise "could not decode #{line} with final col #{col}" unless col.min == col.max

      row  = row.min
      col  = col.min

      Seat.new(
        line,
        row,
        col
      )
    end
  end
end

class Range
  def mid
    (max + min) / 2
  end
end

boarding_passes = lines.map do |line|
  BoardingPass.new(line)
end

max_seat_pass = boarding_passes.max_by do |pass|
  pass.seat.seat_id
end

puts max_seat_pass.seat.seat_id

all_seat_ids = boarding_passes.map do |pass|
  pass.seat.seat_id
end
(all_seat_ids.min..all_seat_ids.max).each do |id|
  if !all_seat_ids.include?(id) && all_seat_ids.include?(id - 1) && all_seat_ids.include?(id + 1)
    puts id
    break
  end
end
