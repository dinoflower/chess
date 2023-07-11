# frozen_string_literal: true

require_relative '../move_checker'

# This class represents a generic chess piece for either (black or white) player.
class Piece
  include MoveChecker
  attr_accessor :location
  attr_reader :color, :type, :symbol

  def initialize(**opts)
    @color = opts[:color]
    @location = opts[:location]
    @type = piece_type
    @symbol = piece_symbol
    @moves = moveset

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
