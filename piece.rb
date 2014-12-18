class Piece
  attr_reader :board, :color

  attr_accessor :pos
  
  def initialize pos, color, board
    @pos = pos
    @color = color
    @board = board
  end

  def move_into_check?(end_pos)
    board_dup = board.dup
    board_dup.move!(pos, end_pos)
    board_dup.in_check?(color)
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end
end
