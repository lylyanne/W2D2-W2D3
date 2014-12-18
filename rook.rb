require_relative './sliding_pieces.rb'

class Rook < SlidingPiece

  def move_dirs
    ORTHOGONALS
  end

  def symbol
    color == :white ? '♖'.colorize(:white) : '♜'.colorize(:black)
    # :r
  end
end


# board = Board.new
# r = Rook.new([4,4],:white, board)
# p r.moves
