# frozen_string_literal: true

require_relative '../move_checker'
require_relative '../board'

# This class represents a generic chess piece for either (black or white) player.
class Piece
  include MoveChecker
  attr_accessor :location, :moved
  attr_reader :color, :type, :symbol

  def initialize(**opts)
    @color = opts[:color]
    @location = opts[:location]
    @grid = opts[:grid]
    @type = piece_type
    @symbol = piece_symbol
    @moves = moveset
    @moved = false

    post_initialize
  end

  def king?
    @type == 'king'
  end

  private

  def post_initialize; end

  def piece_type
    raise NotImplementedError
  end

  def piece_symbol
    raise NotImplementedError
  end

  def moveset
    raise NotImplementedError
  end
end
