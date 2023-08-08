# frozen_string_literal: true

require_relative 'piece'

# The Pawn subclass of Piece.
class Pawn < Piece
  def post_initialize; end

  def check_path(target, finish)
    avail_moves = check_moves(possible_moves)
    avail_captures = check_moves(possible_captures)
    return unless avail_moves.any?(finish) || avail_captures.any?(finish)

    confirm_move(avail_moves, avail_captures, finish, target)
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

  def possible_moves
    @moved ? regular_move : [regular_move, double_move].flatten(1)
  end

  def confirm_move(moves, captures, finish, target)
    return if captures.any?(finish) && target.nil?
    # return unless capture_en_passant?(captures, finish, target)
    return unless valid_move?(moves, finish, target) || captures.any?(finish) && target.opposite?(@color)

    finish
  end

  def valid_move?(moves, finish, target)
    moves.any?(finish) && target.nil?
  end

  def valid_capture?(captures, finish, target)
    captures.any?(finish) && target.opposite?(@color)
  end

  def capture_en_passant?(captures, finish, target)
    return unless captures.any?(finish) && target.nil?

    passed_square = [finish[0], @location[1]]
    return unless occupied(passed_square) && simplify_piece(passed_square).type == 'pawn'
    return if ally(passed_square)

    opponent.previous_piece == passed_square
  end

  def regular_move
    @color == 'white' ? [[-1, 0]] : [[1, 0]]
  end

  def double_move
    @color == 'white' ? [[-2, 0]] : [[2, 0]]
  end

  def possible_captures
    @color == 'white' ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
  end

  def piece_type
    'pawn'
  end

  def moveset
    all_moves = [regular_move.flatten, double_move.flatten]
    possible_captures.each { |captures| all_moves << captures }
    all_moves
  end

  def piece_symbol
    '♟'
  end
end

# TODO: implement en passant
