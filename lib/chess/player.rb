# frozen_string_literal: true

# This class represents a (black or white) chess player.
class Player
  def initialize(color = 'white')
    @color = color
    @pieces = {}
  end
end
