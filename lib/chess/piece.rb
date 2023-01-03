# frozen_string_literal: true

# This class represents a generic chess piece for either (black or white) player.
class Piece
  attr_reader :color, :type, :x, :y

  def initialize(color)
    @color = color
  end

  def to_s; end
end

# The King subclass of Piece.
class King < Piece
  def initialize(color)
    super(color)
    @type = 'king'
    @x = 4
    @y = color == 'white' ? 0 : 7
  end

  def to_s
    @color == 'white' ? '♔' : '♚'
  end
end

# The Queen subclass of Piece.
class Queen < Piece
  def initialize(color)
    super(color)
    @type = 'queen'
    @x = 3
    @y = color == 'white' ? 0 : 7
  end

  def to_s
    @color == 'white' ? '♕' : '♛'
  end
end

# The Rook subclass of Piece.
class Rook < Piece
  def initialize(color)
    super(color)
    @type = 'rook'
    @y = color == 'white' ? 0 : 7
    @x = nil # each side has two, may need method to determine
  end

  def to_s
    @color == 'white' ? '♖' : '♜'
  end
end

# The Bishop subclass of Piece.
class Bishop < Piece
  def initialize(color)
    super(color)
    @type = 'bishop'
    @y = color == 'white' ? 0 : 7
    @x = nil # each side has two, may need method to determine
  end

  def to_s
    @color == 'white' ? '♗' : '♝'
  end
end

# The Knight subclass of Piece.
class Knight < Piece
  def initialize(color)
    super(color)
    @color = color
    @type = 'knight'
    @y = color == 'white' ? 0 : 7
    @x = nil # each side has two, may need method to determine
  end

  def to_s
    @color == 'white' ? '♘' : '♞'
  end
end

# The Pawn subclass of Piece.
class Pawn < Piece
  def initialize(color)
    super(color)
    @type = 'pawn'
    @y = color == 'white' ? 1 : 6
    @x = nil # whatever the starting location is - will probably be determined by a method - possibly outside or factory method?
  end

  def to_s
    @color == 'white' ? '♙' : '♟'
  end
end

# is this superclass necessary abstraction or messing up my duck typing?
