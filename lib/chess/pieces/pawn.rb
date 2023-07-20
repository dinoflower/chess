# frozen_string_literal: true

require_relative 'piece'

# The Pawn subclass of Piece.
class Pawn < Piece
  def post_initialize; end

  def check_path(player, target, finish)
    avail_moves = check_moves(valid_moves)
    avail_captures = check_moves(valid_captures)
    return unless avail_moves.any?(finish) || avail_captures.any?(finish)

    confirm_move(avail_moves, avail_captures, finish, target, player)
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

  def valid_moves
    @moved ? regular_move : [regular_move, double_move].flatten(1)
  end

  def confirm_move(moves, captures, finish, target, player)
    return unless moves.any?(finish) && target.nil? || captures.any?(finish) && target.opposite?(player.color)

    finish
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

  def piece_type
    'pawn'
  end

  def moveset
    [regular_move.flatten, double_move.flatten]
  end

  def piece_symbol
    '♟'
  end
end

# TODO: implement en passant
