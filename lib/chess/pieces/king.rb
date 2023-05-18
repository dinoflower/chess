# frozen_string_literal: true

require_relative 'piece'

module Chess
  # The King piece type.
  class King < Piece
    VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
    def initialize(**opts)
      @symbol = confirm_symbol(opts[:color])
      super
    end

    def check_path(player, target, finish)
      avail_moves = check_moves
      return unless avail_moves.any?(finish)

      return finish if target.nil? || target.opposite?(player.color)
    end

    private

    def default_type
      'king'
    end

    def valid_moves
      VALID_MOVES
    end

    def confirm_symbol(color)
      color == 'white' ? '♔' : '♚'
    end
  end
end
