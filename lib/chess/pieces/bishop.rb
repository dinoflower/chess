# frozen_string_literal: true

require_relative 'piece'

# The Bishop piece type.
class Bishop < Piece
  MOVESET = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  def post_initialize; end

  def check_path(target, finish)
    avail_moves = check_moves(@moves)
    return unless avail_moves.any?(finish)

    return finish if target.nil? || enemy(finish)
  end

  # experimental version to fix problem with check
  # that prevents player from blocking King with own pieces
  def check_moves(moves)
    avail_moves = []
    moves.each do |move|
      temp = shift(move, @location)
      while on_board(temp) && simplify_piece(temp).nil?
        avail_moves << temp
        temp = shift(move, temp)
      end
      avail_moves << enemy(temp) if enemy(temp) && on_board(temp)
    end
    avail_moves
  end

  private

  def piece_type
    'bishop'
  end

  def moveset
    MOVESET
  end

  def piece_symbol
    '♝'
  end
end
