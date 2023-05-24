# frozen_string_literal: true

require_relative 'piece'

# The Bishop piece type.
class Bishop < Piece
  VALID_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze # another loop/recursive method
  def post_initialize; end

  # this method is definitely doing too much already - break it up
  def check_path(player, start, target, finish)
    avail_moves = check_moves
    queue = [Bishop.new(color: player.color, location: start)]
    until queue.empty?
      current = queue.shift
      return current if current.location == target

      current.avail_moves.each do |move|
        next unless square_valid?(move)

        current.children << temp = Bishop.new(color: player_color, location: current.location)
        queue << temp
      end
    end
  end

  def square_valid?; end

  private

  def piece_type
    'bishop'
  end

  def valid_moves
    VALID_MOVES
  end

  def piece_symbol
    '♝'
  end
end
