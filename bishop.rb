require_relative './sliding_pieces.rb'

class Bishop < SlidingPiece

  def move_dirs
    DIAGONALS
  end

  def symbol
    color == :white ? '♗'.colorize(:white) : '♝'.colorize(:black)
    # :b
  end
end

# board = Board.new
# b = Bishop.new([4,4],:white, board)
# p b.moves
