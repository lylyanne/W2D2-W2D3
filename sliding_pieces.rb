require_relative './piece.rb'

class SlidingPiece < Piece

  ORTHOGONALS = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  DIAGONALS = [[1, 1], [-1, -1], [1,-1], [-1,1]]

  def initialize pos, color, board
    super
  end

  def moves
    #sub class will implement move_dirs
    moves = []
    move_dirs.each do |offset|
      current_pos = pos
      loop do
        current_pos = [current_pos[0] + offset[0], current_pos[1] + offset[1]]
        break if Board.offboard?(current_pos) || hits_piece?(current_pos)
        moves << current_pos
        break if capture_piece(current_pos)
      end
    end
    # legal_moves = moves.reject { | move | move_into_check?(move) }
    moves
  end

  def hits_piece?(position)
    x, y = position
    !board.grid[x][y].nil? && board.grid[x][y].color == color
  end

  def capture_piece(position)
    x, y = position
    board.grid[x][y].nil? || board.grid[x][y].color != color
  end
end
