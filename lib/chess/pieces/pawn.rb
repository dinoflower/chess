# frozen_string_literal: true

require_relative 'piece'

# The Pawn subclass of Piece.
class Pawn < Piece
  attr_accessor :passable
  attr_reader :captures

  def post_initialize
    @passable = false
    @captures = possible_captures
  end

  def check_path(target_piece, target_loc)
    avail_moves = check_moves(possible_moves)
    avail_captures = check_moves(@captures)
    return unless avail_moves.any?(target_loc) || avail_captures.any?(target_loc)

    confirm_move(avail_moves, avail_captures, target_loc, target_piece)
  end

  def check_moves(moves)
    next_moves = moves.map do |move|
      move.filter_map.with_index do |coord, index|
        coord + @location[index] unless (coord + @location[index]).negative? || (coord + @location[index]) > 7
      end
    end
    next_moves.keep_if { |move| move.length == 2 }
  end

  def toggle_passable(passablity)
    @passable = passablity ? true : false
  end

  private

  def possible_moves
    @moved ? regular_move : [regular_move, double_move].flatten(1)
  end

  def possible_captures
    @color == 'white' ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
  end

  def confirm_move(moves, captures, target_loc, target_piece)
    return if captures.any?(target_loc) && target_piece.nil?
    return unless valid_moves?(moves, target_loc, target_piece) || valid_captures?(captures, target_loc, target_piece)

    target_loc
  end

  def valid_moves?(moves, target_loc, target_piece)
    moves.any?(target_loc) && target_piece.nil?
  end

  def valid_captures?(captures, target_loc, target_piece)
    captures.any?(target_loc) && target_piece.opposite?(@color)
  end

  def regular_move
    @color == 'white' ? [[-1, 0]] : [[1, 0]]
  end

  def double_move
    @color == 'white' ? [[-2, 0]] : [[2, 0]]
  end

  def piece_type
    'pawn'
  end

  def moveset
    all_moves = [regular_move.flatten, double_move.flatten]
    possible_captures.each { |captures| all_moves << captures }
    all_moves
  end

  def piece_symbol
    '♟'
  end
end
