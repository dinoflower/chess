# frozen_string_literal: true

class Piece
  attr_reader :location, :symbol, :color

  def initialize(color)
    @color = color
  end
end

class King < Piece
  def initialize(color)
    super(color)
    @symbol = color == 'white' ? String.new('♔', encoding: 'UTF-8') : String.new('♚', encoding: 'UTF-8')
    @type = 'king'
    @location = color == 'white' ? 'e1' : 'e8'
  end
end

class Queen < Piece
  def initialize(color)
    super(color)
    @symbol = color == 'white' ? String.new('♕', encoding: 'UTF-8') : String.new('♛', encoding: 'UTF-8')
    @type = 'queen'
    @location = color == 'white' ? 'd1' : 'd8'
  end
end

class Rook < Piece
  def initialize(color)
    super(color)
    @symbol = color == 'white' ? String.new('♖', encoding: 'UTF-8') : String.new('♜', encoding: 'UTF-8')
    @type = 'rook'
    @location = nil # each side has two, may need method to determine
  end
end

class Bishop < Piece
  def initialize(color)
    super(color)
    @symbol = color == 'white' ? String.new('♗', encoding: 'UTF-8') : String.new('♝', encoding: 'UTF-8')
    @type = 'rook'
    @location = nil # each side has two, may need method to determine
  end
end

class Knight < Piece
  def initialize(color)
    super(color)
    @color = color
    @symbol = color == 'white' ? String.new('♘', encoding: 'UTF-8') : String.new('♞', encoding: 'UTF-8')
    @type = 'knight'
    @location = nil # each side has two, may need method to determine
  end
end

class Pawn < Piece
  def initialize(color)
    super(color)
    @symbol = color == 'white' ? String.new('♙', encoding: 'UTF-8') : String.new('♟', encoding: 'UTF-8')
    @type = 'pawn'
    @location = nil # whatever the starting location is - will probably be determined by a method - possibly outside or factory method?
  end
end
