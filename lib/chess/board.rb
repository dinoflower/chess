# frozen_string_literal: true

require_relative 'ui'

# This class represents a standard chess board.
class Board
  include UI
  attr_accessor :grid
  attr_reader :last_piece

  def initialize(grid: generate_board)
    @grid = grid
    set_board
    @previous_pos = nil
    @current_pos = nil
    @last_piece = nil
  end

  def make_play(start, target_loc)
    piece = @grid[start[0]][start[1]]
    move_piece(start, target_loc)
    promote(piece, target_loc) if piece.type == 'pawn' && piece.crossed_board?
    update_passable(piece, start, target_loc) if piece.type == 'pawn'
    piece.moved = true
    @last_piece = piece
  end

  def update_passable(piece, start, target_loc)
    passablity = pawn_double_advance?(start, target_loc)
    piece.toggle_passable(passablity)
  end

  def pawn_double_advance?(start, target_loc)
    (start.first - target_loc.first).abs == 2
  end

  def test_move(start, target_loc)
    @previous_pos = @grid[start[0]][start[1]]
    @current_pos = @grid[target_loc[0]][target_loc[1]]
    move_piece(start, target_loc)
  end

  def move_piece(start, target_loc)
    piece = @grid[start[0]][start[1]]
    piece.location = target_loc
    @grid[target_loc[0]][target_loc[1]] = piece
    @grid[start[0]][start[1]] = nil
  end

  def reset_move(start, target_loc)
    @grid[start[0]][start[1]] = @previous_pos
    @grid[target_loc[0]][target_loc[1]] = @current_pos
    @grid[start[0]][start[1]].location = start
  end

  private

  def select_promotion(color, coords)
    case select_new
    when 'Q' then Queen.new(grid: @grid, color: color, location: [coords[0], coords[1]])
    when 'R' then Rook.new(grid: @grid, color: color, location: [coords[0], coords[1]])
    when 'B' then Bishop.new(grid: @grid, color: color, location: [coords[0], coords[1]])
    when 'N' then Knight.new(grid: @grid, color: color, location: [coords[0], coords[1]])
    end
  end

  def promote(piece, coords)
    @grid[coords[0]][coords[1]] = select_promotion(piece.color, coords)
  end

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
