require_relative './piece.rb'

class SteppingPiece < Piece


  def moves
    #sub class will implement move_dirs
    moves = []
    move_dirs.each do |offset|
      current_pos = pos
      current_pos = [current_pos[0] + offset[0], current_pos[1] + offset[1]]
      moves << current_pos unless Board.offboard?(current_pos) || hits_piece?(current_pos)
    end
    moves
  end

  def hits_piece?(position)
    x, y= position
    !(board.grid[x][y].nil? || board.grid[x][y].color == self.color)
  end

end
