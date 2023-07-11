# frozen_string_literal: true

require_relative 'piece'

# The Pawn subclass of Piece.
class Pawn < Piece
  def post_initialize; end

  # TODO: check_moves will take valid_moves as an argument
  # TODO: break out another piece to check for captures
  def check_path(player, target, finish)
    avail_moves = check_moves(@moves)
    return unless avail_moves.any?(finish)

    return finish if target.nil? || target.opposite?(player.color) # placeholder: only applies if not capture
  end

  private

  def piece_type
    'pawn'
  end

  def moveset
    [regular_move.flatten, double_move.flatten]
  end

  # probably don't want to handle captures in the same place
  def valid_moves
    if @moved == true
      [regular_move, valid_captures].flatten(1)
    else
      [regular_move, double_move, valid_captures].flatten(1)
    end
  end

  def regular_move
    @color == 'white' ? [[-1, 0]] : [[1, 0]]
  end

  def double_move
    @color == 'white' ? [[-2, 0]] : [[2, 0]]
  end

  def valid_captures
    @color == 'white' ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
  end

  def piece_symbol
    '♟'
  end
end
