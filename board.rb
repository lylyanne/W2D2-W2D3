require_relative 'pawn'
require_relative 'rook'
require_relative 'bishop'
require_relative 'king'
require_relative 'queen'
require_relative 'knight'

class Board
  DECIPHER_MOVE = {
           "a" => 0,
           "b" => 1,
           "c" => 2,
           "d" => 3,
           "e" => 4,
           "f" => 5,
           "g" => 6,
           "h" => 7,
           "8" => 0,
           "7" => 1,
           "6" => 2,
           "5" => 3,
           "4" => 4,
           "3" => 5,
           "2" => 6,
           "1" => 7 }

  attr_accessor :grid
  def initialize(grid = Array.new(8) {Array.new(8)}, create = true )
    @grid = grid
    create_board if create == true
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
        #p "#{self[pos].moves} #{self[pos].class}"
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

  def get_move
    puts "Enter your move:"
    start_move, end_move = gets.chomp.gsub(" ","").split(",")
    start_move = [DECIPHER_MOVE[start_move[0]], DECIPHER_MOVE[start_move[1]]]
    end_move = [DECIPHER_MOVE[end_move[0]], DECIPHER_MOVE[end_move[1]]]
    #possible raise if entered values are not in the dictionary
    [start_move, end_move]
  end

  def move (start, end_pos)
    #raise IllegalMove if #cant legally do the move or the start is empty
      # self[end_pos].pos =
      # self[end_pos] = nil
      self[end_pos] = self[start]
      p self[end_pos].class
      self[end_pos].pos = end_pos
      self[start] = nil
  end

  def dup
    duped_grid = grid.map(&:dup)
    self.class.new(duped_grid, false)
  end

end


b = Board.new(grid = Array.new(8) {Array.new(8)}, create = false)
b.grid[7][7] = King.new([7,7], :white, b)
b.grid[7][6] = Queen.new([7,6], :white, b)
b.grid[2][7] = Rook.new([2,7], :black, b)
a = b.dup
p a.grid[7][7].class
p b.grid[7][6].moves
# b.grid[5][5] = Pawn.new([5,5], :black, b)
# p b.grid[1][3].moves
#  # pos = [1, 3]
#  # p b[pos].color
# # p b.in_check?(:black)
# # b.get_move
# p b.grid[6][4].class
# p b.grid[5][5].class
# b.move([6,4], [5,5])
# p b.grid[6][4].class
# p b.grid[5][5].class
# # did the sliding_piece cawpture_piece, but thats it
# c = b.dup
# p c.grid[5][5].class
