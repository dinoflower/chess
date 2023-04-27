# frozen_string_literal: true

require_relative 'piece'

# This class represents a standard chess board.
class ChessSet
  attr_accessor :board

  def initialize(board: generate_board)
    @board = board
    set_board
  end

  def move_piece(start, target)
    piece = simplify_piece(start)
    piece.location = target
    @board[target[0]][target[1]] = piece
    @board[start[0]][start[1]] = nil
  end

  def print_board
    print "    0 1 2 3 4 5 6 7\n"
    print "    _ _ _ _ _ _ _ _\n"
    @board.each_with_index do |row, i|
      print "#{i}: |", row.map { |square| square.nil? ? '_' : square.symbol }.join('|'), "|\n"
    end
  end

  def simplify_piece(array)
    @board[array[0]][array[1]]
  end

  private

  def generate_board
    Array.new(8) { Array.new(8) }
  end

  def set_board
    set_black
    set_white
    set_pawns
  end

  def set_black
    @board[0][0] = Rook.new('black', [0, 0])
    @board[0][1] = Knight.new('black', [0, 1])
    @board[0][2] = Bishop.new('black', [0, 2])
    @board[0][3] = Queen.new('black', [0, 3])
    @board[0][4] = King.new('black', [0, 4])
    @board[0][5] = Bishop.new('black', [0, 5])
    @board[0][6] = Knight.new('black', [0, 6])
    @board[0][7] = Rook.new('black', [0, 7])
  end

  def set_white
    @board[7][0] = Rook.new('white', [7, 0])
    @board[7][1] = Knight.new('white', [7, 1])
    @board[7][2] = Bishop.new('white', [7, 2])
    @board[7][3] = Queen.new('white', [7, 3])
    @board[7][4] = King.new('white', [7, 4])
    @board[7][5] = Bishop.new('white', [7, 5])
    @board[7][6] = Knight.new('white', [7, 6])
    @board[7][7] = Rook.new('white', [7, 7])
  end

  # can the factory method call be isolated?
  def set_pawns
    i = 0
    until i >= 8
      @board[1][i] = PieceFactory.call(type: 'pawn', color: 'black', location: [1, i])
      @board[6][i] = PieceFactory.call(type: 'pawn', color: 'white', location: [6, i])
      i += 1
    end
  end
end

# factory module for piece creation
module PieceFactory
  def self.call(params)
    case params[:type]
    when 'king'
      King.new(params[:color], params[:location])
    when 'queen'
      Queen.new(params[:color], params[:location])
    when 'rook'
      Rook.new(params[:color], params[:location])
    when 'bishop'
      Bishop.new(params[:color], params[:location])
    when 'knight'
      Knight.new(params[:color], params[:location])
    else
      Pawn.new(params[:color], params[:location])
    end
  end
end
