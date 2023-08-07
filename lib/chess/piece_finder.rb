# frozen_string_literal: true

# A module to contain the logic for finding pieces of a given color or type.
module PieceFinder
  def find_player_pieces(color)
    pieces = []
    @grid.each do |row|
      row.each do |piece|
        pieces << piece unless piece.nil? || piece.color != color
      end
    end
    pieces
  end

  def find_king(color)
    king = find_player_pieces(color).select(&:king?)
    king.first.location
  end

  def find_rooks(color)
    rooks = find_player_pieces(color).select { |piece| piece.type == 'rook' }
    rooks.map(&:location)
  end
end
