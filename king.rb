require_relative './stepping_pieces.rb'

class King < SteppingPiece
  KING_MOVES = [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, -1], [1,-1], [-1,1]]

  def symbol
    color == :white ? '♔'.colorize(:white) : '♚'.colorize(:black)
    # :k
  end

  def move_dirs
    KING_MOVES
  end
end


# board = Board.new
# k = King.new([0,0],:white, board)
# p k.moves
