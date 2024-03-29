# frozen_string_literal: true

require_relative '../move_checker'

# This class represents a generic chess piece for either (black or white) player.
class Piece
  include MoveChecker
  attr_accessor :location, :moved
  attr_reader :color, :type, :symbol, :moves

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

  def crossed_board?
    (@location.first.zero? && @color == 'white') || (@location.first == 7 && @color == 'black')
  end

  def to_s
    "#{@color} #{@type}"
  end

  def king?
    @type == 'king'
  end

  def pawn?
    @type == 'pawn'
  end

  def check_moves(moves)
    raise NotImplementedError
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
