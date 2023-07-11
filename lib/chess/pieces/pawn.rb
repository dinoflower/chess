# frozen_string_literal: true

require_relative 'piece'

# The Pawn subclass of Piece.
class Pawn < Piece
  attr_reader :moved

  # TODO: add a way to update
  def post_initialize
    @moved = false
  end

  # TODO: check_moves will take valid_moves as an argument
  def check_path(target, finish)
    avail_moves = check_moves(@moves)
    return unless avail_moves.any?(finish)

    return finish if target.nil?
  end

  private

  def piece_type
    'pawn'
  end

  def moveset
    [regular_move, double_move]
  end

  def valid_moves
    # find the valid_moves
  end

  def regular_move
    @color == 'white' ? [-1, 0] : [1, 0]
  end

  def double_move
    @color == 'white' ? [-2, 0] : [2, 0]
  end

  def valid_captures
    @color == 'white' ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
  end

  def piece_symbol
    '♟'
  end
end
