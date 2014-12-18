require_relative 'pawn'
require_relative 'rook'
require_relative 'bishop'
require_relative 'king'
require_relative 'queen'
require_relative 'knight'
require 'byebug'

class IllegalMoveError < ArgumentError
end

class Board
  attr_accessor :grid

  def initialize( options = {})
    default = {:grid => Array.new(8) { Array.new(8) }, :create => true}

    options = default.merge(options)
    @grid = options[:grid]
    create_board if options[:create]
    # p @grid
    # p options
  end

  def self.offboard?(position)
    x, y = position
    !(x.between?(0,7) && y.between?(0,7))
  end

  def []=(pos, value)
    x, y = pos
    self.grid[x][y] = value
  end

  def [](pos)
    x, y = pos
    self.grid[x][y]
  end

  def piece_class
    self.grid[x][y].class
  end

  def create_board
    0.upto(7) do |column|
      self[[1, column]] = Pawn.new( [1, column], :black, self)
      self[[6, column]] = Pawn.new( [6, column], :white, self)
    end

    rook_positions = [0,7].repeated_permutation(2).to_a.each do |rook|
      color = (rook.first == 0 ? :black : :white)
      self[rook] = Rook.new( rook, color, self)
    end

    [[0, 1], [0, 6], [7, 1], [7, 6]].each do |knight|
      color = (knight.first == 0 ? :black : :white)
      self[knight] = Knight.new( knight, color, self)
    end

    [[0, 2], [0, 5], [7, 2], [7, 5]].each do |bishop|
      color = (bishop.first == 0 ? :black : :white)
      self[bishop] = Bishop.new( bishop, color, self)
    end

    [[0,3],[7,3]].each do |queen|
      color = (queen.first == 0 ? :black : :white)
      self[queen] = Queen.new( queen, color, self)
    end

    [[0,4],[7,4]].each do |king|
      color = (king.first == 0 ? :black : :white)
      self[king] = King.new( king, color, self)
    end
  end

  def in_check?(color)
    king_position = find_king(color)
    (0..7).each do |row|
      (0..7).each do |column|
        pos = [row, column]
        next if self[pos].nil? || self[pos].color == color
         return true if self[pos].moves.include?(king_position)
      end
    end

    false
  end

  def find_king(color)
    (0..7).each do |row|
      (0..7).each do |column|
        pos = [row, column]
        return pos if self[pos].is_a?(King) && self[pos].color == color
      end
    end
  end

  def move!(start, end_pos)
      self[end_pos] = self[start] #reassigns position on the board
      self[end_pos].pos = end_pos #reassigns pos of the piece
      # byebug
      self[start] = nil
  end

  def move(start, end_pos)
    #p self[start].class
    raise IllegalMoveError if self[start].nil?
    legal_moves = self[start].valid_moves
    p "Legal moves: #{legal_moves}"
    raise IllegalMoveError unless legal_moves.include?(end_pos)
  end

  def dup
    array_of_pieces = grid.flatten.compact
    # debugger
    board_dup = Board.new(:create => false)
    array_of_pieces.each do |p|
      board_dup[p.pos] = p.class.new(p.pos.dup, p.color, board_dup)
    end
    board_dup
  end

  def checkmate?(color)
    # get all white pieces
    valid_moves_status = false
    same_color_pieces = grid.flatten.compact.select { |p| p.color == color}
    #p same_color_pieces
    same_color_pieces.each do |piece|
      #p piece.valid_moves
      valid_moves_status = true if piece.valid_moves.empty?
    end

    in_check?(color) && valid_moves_status
    #iterate over all white pieces, any valid moves?
    #if false, true, its checkmate
    #if true, then not checkmate
  end

  def render
    # print (0...8).each { |y| print "#{y.to_s} "}
    puts
    grid.map.with_index do |row, i|
      # print "#{i.to_s} "
      row.map do |tile|
        tile.nil? ? "_ " : "#{tile.symbol} "
      end.join("")
    end.join("\n")
  end
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new(:create => true)
  # p b.move!([7,6], [5,5])
  # puts b.render
  # p b.move!([5,5], [3,4])
  # puts b.render
  # p b.grid[3][4].class
end
