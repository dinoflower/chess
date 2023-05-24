# frozen_string_literal: true

require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

# This class represents a standard chess board.
class Board
  attr_accessor :grid

  def initialize(grid: generate_board)
    @grid = grid
    set_board
  end

  def move_piece(start, target)
    piece = @grid[start[0]][start[1]]
    piece.location = target
    @grid[target[0]][target[1]] = piece
    @grid[start[0]][start[1]] = nil
  end

  private

  def generate_board
    Array.new(8) { Array.new(8) }
  end

  def set_board
    set_row('black', 0)
    set_row('white', 7)
    set_pawns
  end

  def set_row(color, number)
    @grid[number] = [
      Rook.new(color: color, location: [number, 0]),
      Knight.new(color: color, location: [number, 1]),
      Bishop.new(color: color, location: [number, 2]),
      Queen.new(color: color, location: [number, 3]),
      King.new(color: color, location: [number, 4]),
      Bishop.new(color: color, location: [number, 5]),
      Knight.new(color: color, location: [number, 6]),
      Rook.new(color: color, location: [number, 7])
    ]
  end

  def set_pawns
    i = 0
    until i >= 8
      @grid[1][i] = Pawn.new(color: 'black', location: [1, i])
      @grid[6][i] = Pawn.new(color: 'white', location: [6, i])
      i += 1
    end
  end
end
