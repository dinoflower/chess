# frozen_string_literal: true

require_relative 'piece'

module Chess
  # The Bishop piece type.
  class Bishop < Piece
    VALID_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze # another loop/recursive method
    def initialize(**opts)
      @symbol = confirm_symbol(opts[:color])
      super
    end

    def check_path(player, target, finish); end

    private

    def default_type
      'bishop'
    end

    def valid_moves
      VALID_MOVES
    end

    def confirm_symbol(color)
      color == 'white' ? '♗' : '♝'
    end
  end
end