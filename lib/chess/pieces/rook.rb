# frozen_string_literal: true

require_relative 'piece'

# The Rook piece type.
class Rook < Piece
  MOVESET = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze # will need loop or recursion to get the full line
  def post_initialize; end

  def check_path(player, target, finish); end

  private

  def piece_type
    'rook'
  end

  def moveset
    MOVESET
  end

  def piece_symbol
    '♜'
  end
end
