# frozen_string_literal: true

class Board
  def initialize(filename:)
    @board = File.read(filename).split("\n")
  end

  def width
    @board.first.size
  end

  def height
    @board.size
  end

  def tree?(pos_x, pos_y)
    @board[pos_y % height][pos_x % width] == '#'
  end
end

Pattern = Struct.new(:dx, :dy) do
  def number_of_trees(board)
    x = 0
    y = 0
    count = 0

    while y < board.height
      count += 1 if board.tree?(x, y)

      x += dx
      y += dy
    end
    count
  end
end

board = Board.new(filename: 'day3.txt')
pattern = Pattern.new(3, 1)

puts pattern.number_of_trees(board)
