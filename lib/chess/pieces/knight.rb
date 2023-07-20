# frozen_string_literal: true

require_relative 'piece'

# The Knight piece type.
class Knight < Piece
  MOVESET = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]].freeze
  def post_initialize; end

  def check_path(player, target, finish)
    avail_moves = check_moves(@moves)
    return unless avail_moves.any?(finish)

    return finish if target.nil? || target.opposite?(player.color)
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
    'knight'
  end

  def moveset
    MOVESET
  end

  def piece_symbol
    '♞'
  end
end
