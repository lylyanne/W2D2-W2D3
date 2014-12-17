class Piece
  attr_reader :pos, :board, :color
  def initialize pos, color, board
    @pos = pos
    @color = color
    @board = board
  end
end
