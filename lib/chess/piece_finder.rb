# frozen_string_literal: true

require 'pry-byebug'

# A module to contain the logic for finding pieces of a given color or type.
module PieceFinder
  def find_player_pieces(color)
    pieces = []
    @grid.each do |row|
      row.each do |piece|
        unless piece.nil?
          pieces << piece if piece.color == color
        end
      end
    end
    pieces
  end

  def find_king(color)
    king = find_player_pieces(color).select { |piece| piece.king? }
    king.first.location
  end
end
