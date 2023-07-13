# frozen_string_literal: true

require_relative 'piece'

# The Bishop piece type.
class Bishop < Piece
  MOVESET = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze # another loop/recursive method
  def post_initialize; end

  def check_path(player, target, finish)
    # move_queue = check_moves(@moves)
    # go through queue with #shift using #check_moves to stay on board (seems redundant)
    # check each space while passing to make sure it's empty or the target(?)

    return finish if target.nil? || target.opposite?(player.color)
  end

  private

  # increment a temp location by moving the location value along one move path?
  # def shift(move, temp_location)
    # [move(0) + temp_location(0), move(1) + temp_location(1)]
  # end

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

# from previous project, for reference
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

# do something like call #check_moves and add the results to a queue
# if the results meet the same criteria as in #check_path
# then check the results from the queue
# but not any that aren't along the correct path
