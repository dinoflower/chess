# frozen_string_literal: true

require_relative 'piece'

# The King piece type.
class King < Piece
  MOVESET = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  def post_initialize; end

  def check_path(target_piece, target_loc)
    avail_moves = check_moves(@moves)
    return unless avail_moves.any?(target_loc)

    return target_loc if target_piece.nil? || target_piece.opposite?(@color)
  end

  def check_moves(moves)
    next_moves = moves.map do |move|
      move.filter_map.with_index do |coord, index|
        coord + @location[index] unless (coord + @location[index]).negative? || (coord + @location[index]) > 7
      end
    end
    next_moves.keep_if { |move| move.length == 2 }
  end

  private

  def piece_type
    'king'
  end

  def moveset
    MOVESET
  end

  def piece_symbol
    '♚'
  end
end
