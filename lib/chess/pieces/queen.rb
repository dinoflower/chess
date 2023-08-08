# frozen_string_literal: true

require_relative 'piece'

# The Queen piece type.
class Queen < Piece
  MOVESET = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  def post_initialize; end

  def check_path(target, finish)
    avail_moves = check_moves(@moves)
    return unless avail_moves.any?(finish)

    return finish if target.nil? || target.opposite?(@color)
  end

  def check_moves(moves)
    avail_moves = []
    moves.each do |move|
      temp = shift(move, @location)
      until off_board(temp) || occupied(temp)
        avail_moves << temp
        temp = shift(move, temp)
      end
      avail_moves << temp unless off_board(temp) || ally(temp)
    end
    avail_moves
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
