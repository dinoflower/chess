# frozen_string_literal: true

require_relative 'piece'

# This class represents a (black or white) chess player.
class Player
  def initialize(color, pieces)
    @color = color
    @pieces = pieces
  end

  def self.create_player(color)
    pieces = color == 'white' ? set_white : set_black
    Player.new(color, pieces)
  end

  def self.set_white
    pieces = get_pawns('white')
    h = { e1: King.new('white', 'e1'), d1: Queen.new('white', 'd1'), a1: Rook.new('white', 'a1'),
          h1: Rook.new('white', 'h1'), c1: Bishop.new('white', 'c1'), f1: Bishop.new('white', 'f1'),
          b1: Knight.new('white', 'b1'), g1: Knight.new('white', 'g1') }
    pieces.merge(h)
  end

  def self.set_black
    pieces = get_pawns('black')
    h = { e8: King.new('black', 'e8'), d8: Queen.new('black', 'd8'), a8: Rook.new('black', 'a8'),
          h8: Rook.new('black', 'h8'), c8: Bishop.new('black', 'c8'), f8: Bishop.new('black', 'f8'),
          b8: Knight.new('black', 'b8'), g8: Knight.new('black', 'g8') }
    pieces.merge(h)
  end

  def self.get_pawns(color)
    w_pawns = %w[a2 b2 c2 d2 e2 f2 g2 h2]
    b_pawns = %w[a7 b7 c7 d7 e7 f7 g7 h7]
    pieces = {}
    if color == 'white'
      w_pawns.each { |pawn| pieces[pawn.to_sym] = Pawn.new('white', pawn) }
    else
      b_pawns.each { |pawn| pieces[pawn.to_sym] = Pawn.new('black', pawn) }
    end
    pieces
  end
end
