# frozen_string_literal: true

require_relative 'piece'

module Chess
  # The Rook piece type.
  class Rook < Piece
    VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze # will need loop or recursion to get the full line
    def initialize(**opts)
      @symbol = confirm_symbol(opts[:color])
      super
    end

    def check_path(player, target, finish); end

    private

    def default_type
      'rook'
    end

    def valid_moves
      VALID_MOVES
    end

    def confirm_symbol(color)
      color == 'white' ? '♖' : '♜'
    end
  end
end
