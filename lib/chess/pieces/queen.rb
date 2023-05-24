# frozen_string_literal: true

require_relative 'piece'

# The Queen piece type.
class Queen < Piece
  VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  def post_initialize; end

  def check_path(player, target, finish); end

  private

  def piece_type
    'queen'
  end

  def valid_moves
    VALID_MOVES
  end

  def piece_symbol
    '♛'
  end
end
