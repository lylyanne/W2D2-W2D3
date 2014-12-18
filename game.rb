require_relative 'board'
require 'byebug'

class Game
  attr_reader :board, :players, :my_color

  def initialize(player1, player2)
    @board = Board.new(:create => true)
    @players = [player1, player2]
    @my_color = { player1 => :white, player2 => :black }
  end

  def play
    until board.checkmate?(my_color[players[0]])
      begin
        puts board.render
        #0ask checkmate
        start_pos, end_pos = players[0].play_turn
        #debugger
        board.move(start_pos, end_pos)
        move_correct_color?(start_pos)
      rescue IllegalMoveError
        puts "Not a legal move. Please try again."
        retry
      end
      board.move!(start_pos,end_pos)

      players.rotate!
    end
  end

  def move_correct_color?(start_pos)
    raise IllegalMoveError unless my_color[players[0]] == board[start_pos].color
  end
end



class ChessHumanPlayer
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

  def play_turn
    start_pos, end_pos = get_move
    decipher_move(start_pos, end_pos)
  end

   def get_move
    puts "Enter your move:"
    start_pos, end_pos = gets.chomp.gsub(" ","").split(",")
    raise IllegalMoveError if end_pos.nil?
    [start_pos, end_pos]
   end

  def decipher_move(start_pos, end_pos)
    start_pos = [DECIPHER_MOVE[start_pos[1]], DECIPHER_MOVE[start_pos[0]]]
    end_pos = [DECIPHER_MOVE[end_pos[1]], DECIPHER_MOVE[end_pos[0]]]
    raise IllegalMoveError if start_pos[0].nil? || end_pos[0].nil?
    raise IllegalMoveError if start_pos[1].nil? || end_pos[1].nil?
    [start_pos, end_pos]
  end

end

hp1 = ChessHumanPlayer.new
hp2 = ChessHumanPlayer.new
g = Game.new(hp1, hp2)
g.play

# DECIPHER_MOVE = {
#   "a" => 0,
#   "b" => 1,
#   "c" => 2,
#   "d" => 3,
#   "e" => 4,
#   "f" => 5,
#   "g" => 6,
#   "h" => 7,
#   "8" => 0,
#   "7" => 1,
#   "6" => 2,
#   "5" => 3,
#   "4" => 4,
#   "3" => 5,
#   "2" => 6,
#   "1" => 7 }
#
#   start_pos = "n12"
#   end_pos = "p2"
#   p [DECIPHER_MOVE[start_pos[1]], DECIPHER_MOVE[start_pos[0]]]
#   p [DECIPHER_MOVE[end_pos[1]], DECIPHER_MOVE[end_pos[0]]]

# e2, e4
# a7,a6
# e4,e5
