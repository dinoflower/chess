# frozen_string_literal: true

require_relative 'piece'

# This class represents a (black or white) chess player.
class Player
  attr_reader :pieces

  def initialize(color, name)
    @color = color
    @name = name
    @pieces = pieces
  end

  def to_s
    "#{@color.capitalize}, #{@name}"
  end
end
