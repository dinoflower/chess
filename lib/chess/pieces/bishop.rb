# frozen_string_literal: true

require_relative 'piece'

# The Bishop piece type.
class Bishop < Piece
  MOVESET = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze # another loop/recursive method
  def post_initialize; end

  # but with recursion
  def check_path(player, target, finish)
    avail_moves = check_moves(@moves)
    return unless avail_moves.any?(finish)

    return finish if target.nil? || target.opposite?(player.color)
  end

  def square_valid?; end

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

# okay so MAYBE the pieces do have to act as nodes
# def build_tree(start, target) ?
  # queue = [Bishop.new(color: player.color, location: start)]
  # until queue.empty?
    # current = queue.shift
    # return current if current.location == target

    # current.check_moves.each do |move|
      # next unless square_empty?(move)

      # current.children << temp = Bishop.new(self, move, current)
      # queue << temp
    # end
  # end
# end
