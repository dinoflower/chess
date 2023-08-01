# frozen_string_literal: true

require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require 'pry-byebug'

# This class represents a standard chess board.
class Board
  attr_accessor :grid

  def initialize(grid: generate_board)
    @grid = grid
    @previous_pos = nil
    @current_pos = nil
    set_board
  end

  def make_play(start, target)
    piece = @grid[start[0]][start[1]]
    piece.moved = true
    move_piece(start, target)
  end

  def test_move(start, target)
    move_piece(start, target)
  end

  def move_piece(start, target)
    piece = @grid[start[0]][start[1]]
    piece.location = target
    @grid[target[0]][target[1]] = piece
    @grid[start[0]][start[1]] = nil
  end

  def reset_move(start, target)
    piece = @grid[target[0]][target[1]]
    piece.location = start
    @grid[start[0]][start[1]] = piece
    @grid[target[0]][target[1]] = nil
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
      Rook.new(grid: @grid, color: color, location: [number, 0]),
      Knight.new(grid: @grid, color: color, location: [number, 1]),
      Bishop.new(grid: @grid, color: color, location: [number, 2]),
      Queen.new(grid: @grid, color: color, location: [number, 3]),
      King.new(grid: @grid, color: color, location: [number, 4]),
      Bishop.new(grid: @grid, color: color, location: [number, 5]),
      Knight.new(grid: @grid, color: color, location: [number, 6]),
      Rook.new(grid: @grid, color: color, location: [number, 7])
    ]
  end

  def set_pawns
    i = 0
    until i >= 8
      @grid[1][i] = Pawn.new(grid: @grid, color: 'black', location: [1, i])
      @grid[6][i] = Pawn.new(grid: @grid, color: 'white', location: [6, i])
      i += 1
    end
  end
end
