# frozen_string_literal: true

require_relative 'piece'

# This class represents a standard chess board.
class Board
  attr_reader :board

  def initialize
    @board = generate_board
    set_board
  end

  def print_board
    print "    0 1 2 3 4 5 6 7\n"
    print "    _ _ _ _ _ _ _ _\n"
    @board.each_with_index do |row, i|
      print "#{i}: |", row.map { |square| square.nil? ? '_' : square.to_s }.join('|'), "|\n"
    end
  end

  def generate_board
    Array.new(8) { Array.new(8) }
  end

  def set_board
    set_black
    set_white
    set_pawns
  end

  def set_black
    @board[0][0] = Rook.new('black')
    @board[0][1] = Knight.new('black')
    @board[0][2] = Bishop.new('black')
    @board[0][3] = Queen.new('black')
    @board[0][4] = King.new('black')
    @board[0][5] = Bishop.new('black')
    @board[0][6] = Knight.new('black')
    @board[0][7] = Rook.new('black')
  end

  def set_white
    @board[7][0] = Rook.new('white')
    @board[7][1] = Knight.new('white')
    @board[7][2] = Bishop.new('white')
    @board[7][3] = Queen.new('white')
    @board[7][4] = King.new('white')
    @board[7][5] = Bishop.new('white')
    @board[7][6] = Knight.new('white')
    @board[7][7] = Rook.new('white')
  end

  def set_pawns
    i = 0
    until i >= 8
      @board[1][i] = Pawn.new('black')
      @board[6][i] = Pawn.new('white')
      i += 1
    end
  end
end
