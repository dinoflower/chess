# frozen_string_literal: true

require_relative 'piece'

module Chess
  # The Queen piece type.
  class Queen < Piece
    VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
    def initialize(**opts)
      @symbol = confirm_symbol(opts[:color])
      super
    end

    def check_path(player, target, finish); end

    private

    def default_type
      'queen'
    end

    def valid_moves
      VALID_MOVES
    end

    def confirm_symbol(color)
      color == 'white' ? '♕' : '♛'
    end
  end
end
