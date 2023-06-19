# frozen_string_literal: true

require_relative 'piece'

# The Pawn subclass of Piece.
class Pawn < Piece
  VALID_MOVES = [[-1, 0]].freeze
  def post_initialize; end

  # TODO: update to reflect pawn's capture and first move rules
  # what about the arguments for the other type?
  def check_path(target, finish)
    avail_moves = check_moves
    return unless avail_moves.any?(finish)

    return finish if target.nil?
  end

  private

  # replace with checking for parent node? or even a 'moved' quality?
  def on_start?
    (@color == 'white' && @location[0] == 6) || (@color == 'black' && @location[0] == 1)
  end

  def piece_type
    'pawn'
  end

  def valid_moves
    VALID_MOVES
  end

  def piece_symbol
    '♟'
  end
end
