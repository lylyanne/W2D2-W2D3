require_relative './piece.rb'
# encoding: utf-8

# require_relative './board.rb'

class Pawn < Piece

  MOVES = [[1, 1], [1, -1]]

  def symbol
    color == :white ? '♙'.colorize(:white) : '♟'.colorize(:black)
    # :p
  end

  def move_dir
    color == :white ? -1 : 1
  end

  def at_home_row?
    row = pos.first
    if color == :white
      row == 6
    else
      row == 1
    end
  end

  #always return array of all the good moves
  def moves
    one_step_ahead = [pos[0] + move_dir, pos[1]]
    two_steps_ahead = [pos[0] + (2 * move_dir), pos[1]]
    moves = [one_step_ahead, two_steps_ahead]
    moves.reject! { |move| Board.offboard?(move) || hits_piece?(move) }

    MOVES.each do |offset|
      current_pos = pos
      color_offset = [offset[0] * move_dir, offset[1]]
      current_pos = [current_pos[0] + color_offset[0], current_pos[1] + color_offset[1]]
      moves << current_pos unless Board.offboard?(current_pos) || cannot_take_piece?(current_pos)
    end

    moves
  end

  #shouldnt combine logic to make a takeable?- hits_piece and cannot_tak_piece are very different

  def hits_piece?(position)
    x, y = position
    !board.grid[x][y].nil?
    # return false unless board.grid[x][y]
  end

  # def is_empty?(position)
    #board.grid[x][y] == nil
  # end

  def cannot_take_piece?(position)
    x, y = position
    board.grid[x][y].nil? || board.grid[x][y].color == color
  end
end

# board = Board.new
# board.grid[5][5] = Pawn.new([5,5], :black, board)
# board.grid[4][4] = Pawn.new([4,4], :black, board)
# board.grid[5][3] = Pawn.new([5,3], :white, board)
# # p board.grid[4][4].color
# p = Pawn.new([6,4], :white, board)
# p p.moves
# # p p.hits_piece?([5,5], -1)
