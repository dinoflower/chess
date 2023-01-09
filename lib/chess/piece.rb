# frozen_string_literal: true

# This class represents a generic chess piece for either (black or white) player.
class Piece
  attr_reader :color, :type, :location

  def initialize(color)
    @color = color
  end

  def to_s; end
end

# The King subclass of Piece.
class King < Piece
  def initialize(color, location)
    super(color)
    @type = 'king'
    @location = location
  end

  def to_s
    @color == 'white' ? '♔' : '♚'
  end
end

# The Queen subclass of Piece.
class Queen < Piece
  def initialize(color, location)
    super(color)
    @type = 'queen'
    @location = location
  end

  def to_s
    @color == 'white' ? '♕' : '♛'
  end
end

# The Rook subclass of Piece.
class Rook < Piece
  def initialize(color, location)
    super(color)
    @type = 'rook'
    @location = location
  end

  def to_s
    @color == 'white' ? '♖' : '♜'
  end
end

# The Bishop subclass of Piece.
class Bishop < Piece
  def initialize(color, location)
    super(color)
    @type = 'bishop'
    @location = location
  end

  def to_s
    @color == 'white' ? '♗' : '♝'
  end
end

# The Knight subclass of Piece.
class Knight < Piece
  def initialize(color, location)
    super(color)
    @color = color
    @type = 'knight'
    @location = location
  end

  def to_s
    @color == 'white' ? '♘' : '♞'
  end
end

# The Pawn subclass of Piece.
class Pawn < Piece
  def initialize(color, location)
    super(color)
    @type = 'pawn'
    @location = location
  end

  def to_s
    @color == 'white' ? '♙' : '♟'
  end
end

# is this superclass necessary abstraction or messing up my duck typing?
