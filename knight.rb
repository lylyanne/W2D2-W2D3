require_relative './stepping_pieces.rb'

class Knight < SteppingPiece
  KNIGHT_MOVES = [[1,2], [1,-2], [-1,2], [-1,-2], [2,1], [2,-1], [-2,1], [-2,-1]]

  def symbol
    :n
  end

  def move_dirs
    KNIGHT_MOVES
  end
end

# board = Board.new
# k = Knight.new([5,5],:white, board)
# p k.moves
