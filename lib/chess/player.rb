# frozen_string_literal: true

require_relative 'piece'

# This class represents a (black or white) chess player.
class Player
  attr_reader :pieces

  def initialize(color, name, pieces)
    @color = color
    @name = name
    @pieces = pieces
  end

  def self.create_player(color)
    puts 'Please enter your name:'
    name = gets.chomp.capitalize
    pieces = color == 'white' ? set_white : set_black
    Player.new(color, name, pieces)
  end

  def self.set_white
    pieces = get_pawns('white')
    h = { Ke1: King.new('white', 'e1'), Qd1: Queen.new('white', 'd1'), Ra1: Rook.new('white', 'a1'),
          Rh1: Rook.new('white', 'h1'), Bc1: Bishop.new('white', 'c1'), Bf1: Bishop.new('white', 'f1'),
          Nb1: Knight.new('white', 'b1'), Ng1: Knight.new('white', 'g1') }
    pieces.merge(h)
  end

  def self.set_black
    pieces = get_pawns('black')
    h = { Ke8: King.new('black', 'e8'), Qd8: Queen.new('black', 'd8'), Ra8: Rook.new('black', 'a8'),
          Rh8: Rook.new('black', 'h8'), Bc8: Bishop.new('black', 'c8'), Bf8: Bishop.new('black', 'f8'),
          Nb8: Knight.new('black', 'b8'), Ng8: Knight.new('black', 'g8') }
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

  def to_s
    "#{@color.capitalize}, #{@name}"
  end
end
