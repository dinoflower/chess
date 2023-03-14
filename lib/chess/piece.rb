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
  VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  def initialize(color)
    super(color)
    @type = 'king'
  end

  def to_s
    @color == 'white' ? '♔' : '♚'
  end

  def in_check?
    # true if some conditions are met

    false
  end
end

# The Queen subclass of Piece.
class Queen < Piece
  VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  def initialize(color)
    super(color)
    @type = 'queen'
  end

  def to_s
    @color == 'white' ? '♕' : '♛'
  end
end

# The Rook subclass of Piece.
class Rook < Piece
  VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze # will need loop or recursion to get the full line
  def initialize(color)
    super(color)
    @type = 'rook'
  end

  def to_s
    @color == 'white' ? '♖' : '♜'
  end
end

# The Bishop subclass of Piece.
class Bishop < Piece
  VALID_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze # another loop/recursive method
  def initialize(color)
    super(color)
    @type = 'bishop'
  end

  def to_s
    @color == 'white' ? '♗' : '♝'
  end
end

# The Knight subclass of Piece.
class Knight < Piece
  VALID_MOVES = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]].freeze
  def initialize(color)
    super(color)
    @type = 'knight'
  end

  def to_s
    @color == 'white' ? '♘' : '♞'
  end
end

# The Pawn subclass of Piece.
class Pawn < Piece
  VALID_MOVES = [[0, -1]].freeze # either allow for en passant and first move here or add methods for those separately
  def initialize(color)
    super(color)
    @type = 'pawn'
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
