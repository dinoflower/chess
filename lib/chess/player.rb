# frozen_string_literal: true

require_relative 'piece'

# This class represents a (black or white) chess player.
class Player
  attr_reader :pieces

  def initialize(color, name, pieces)
    @color = color
    @name = name
    @pieces = pieces
  end

  def verify_input(piece)
    @pieces.value?(piece)
  end

  def to_s
    "#{@color.capitalize}, #{@name}"
  end
end

# do the pieces even have to belong to the player? the color is enough
