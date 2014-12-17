require_relative './sliding_pieces.rb'

class Queen < SlidingPiece

  def move_dirs
    ORTHOGONALS + DIAGONALS
  end

  def symbol
    :q
  end
end

# board = Board.new
#  q = Queen.new([4,4],:white, board)
# p q.moves
