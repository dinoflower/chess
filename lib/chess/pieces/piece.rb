# frozen_string_literal: true

require_relative '../move_checker'

module Chess
  # This class represents a generic chess piece for either (black or white) player.
  class Piece
    include MoveChecker
    attr_accessor :location
    attr_reader :color, :type, :symbol

    def initialize(**opts)
      @color = opts[:color]
      @location = opts[:location]
      @type = default_type
      @moves = valid_moves
    end

    def king?
      @type == 'king'
    end

    private

    def default_type
      raise NotImplementedError
    end

    def valid_moves
      raise NotImplementedError
    end
  end
end

# post_initialize(opts) to send opts to subclasses instead of expecting them to send to Piece?
