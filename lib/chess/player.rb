# frozen_string_literal: true

require_relative 'piece'

# This class represents a (black or white) chess player.
class Player
  attr_reader :color

  def initialize(color, name)
    @color = color
    @name = name
  end

  def to_s
    "#{@color.capitalize}, #{@name}"
  end
end
