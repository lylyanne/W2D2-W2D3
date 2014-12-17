require_relative 'pawn'
require_relative 'rook'
require_relative 'bishop'
require_relative 'king'
require_relative 'queen'
require_relative 'knight'

class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(8) {Array.new(8)}
    create_board
  end

  def self.offboard?(position)
    x,y = position
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
      self.grid[1][column] = Pawn.new( [1, column], :black, self)
      self.grid[6][column] = Pawn.new( [6, column], :white, self)
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
        p "#{self[pos].moves} #{self[pos].class}"
        # return true if self[pos].moves.include?(king_position)
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


end


b = Board.new
b.grid[0][3] = Queen.new([0,3], :white, b)
 pos = [0, 3]
 p b[pos].color
p b.in_check?(:black)

# in_check is still not working
# did the sliding_piece cawpture_piece, but thats it
