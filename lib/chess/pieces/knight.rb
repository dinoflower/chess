# frozen_string_literal: true

require_relative 'piece'

# The Knight piece type.
class Knight < Piece
  VALID_MOVES = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]].freeze
  def post_initialize; end

  def check_path(player, target, finish)
    avail_moves = check_moves
    return unless avail_moves.any?(finish)

    return finish if target.nil? || target.opposite?(player.color)
  end

  private

  def piece_type
    'knight'
  end

  def valid_moves
    VALID_MOVES
  end

  def piece_symbol
    '♞'
  end
end
