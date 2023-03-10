# frozen_string_literal: true

# This class represents a generic chess piece for either (black or white) player.
class Piece
  attr_accessor :location
  attr_reader :color, :type

  def initialize(color)
    @color = color
  end

  def to_s; end

  def move; end
end

# The King subclass of Piece.
class King < Piece
  VALID_MOVES = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze
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

# see here for how to handle queen, rook, and bishop:
# def check_moves
#   next_moves = VALID_MOVES.map do |move|
#     move.filter_map.with_index do |coord, index|
#       coord + @location[index] unless (coord + @location[index]).negative? || (coord + @location[index]) > 7
#     end
#   end
#   next_moves.keep_if { |move| move.length == 2 }
# end

# still considering x_position and y_position values
