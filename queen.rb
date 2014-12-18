require_relative './sliding_pieces.rb'
# encoding: utf-8

class Queen < SlidingPiece

  def move_dirs
    ORTHOGONALS + DIAGONALS
  end

  def symbol
    color == :white ? '♕'.colorize(:white) : '♛'.colorize(:black)
    # :q
  end
end

# board = Board.new
#  q = Queen.new([4,4],:white, board)
# p q.moves
