# frozen_string_literal: true

require_relative 'piece'

# The Queen piece type.
class Queen < Piece
  MOVESET = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  def post_initialize; end

  def check_path(player, target, finish)
    avail_moves = check_long_moves
    return unless avail_moves.any?(finish)

    return finish if target.nil? || target.opposite?(player.color)
  end

  private

  def piece_type
    'queen'
  end

  def moveset
    MOVESET
  end

  def piece_symbol
    '♛'
  end
end
