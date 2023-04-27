# frozen_string_literal: true

# This class represents a generic chess piece for either (black or white) player.
class Piece
  attr_accessor :location
  attr_reader :color, :moves, :type

  def initialize(color, location)
    @color = color
    @location = location
  end

  def to_s; end

  def move; end

  def opposite?(player_color)
    @color != player_color
  end
end

# The King subclass of Piece.
class King < Piece
  VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  def initialize(color, location)
    super(color, location)
    @moves = VALID_MOVES
    @type = 'king'
  end

  def to_s
    @color == 'white' ? '♔' : '♚'
  end

  def in_check?
    # true if some conditions are met

    false
  end

  # TODO: encapsulate #check_moves and include it as a class or module
  def check_moves
    next_moves = VALID_MOVES.map do |move|
      move.filter_map.with_index do |coord, index|
        coord + @location[index] unless (coord + @location[index]).negative? || (coord + @location[index]) > 7
      end
    end
    next_moves.keep_if { |move| move.length == 2 }
  end
end

# The Queen subclass of Piece.
class Queen < Piece
  VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  def initialize(color, location)
    super(color, location)
    @moves = VALID_MOVES
    @type = 'queen'
  end

  def to_s
    @color == 'white' ? '♕' : '♛'
  end

  def check_moves
    next_moves = VALID_MOVES.map do |move|
      move.filter_map.with_index do |coord, index|
        coord + @location[index] unless (coord + @location[index]).negative? || (coord + @location[index]) > 7
      end
    end
    next_moves.keep_if { |move| move.length == 2 }
  end
end

# The Rook subclass of Piece.
class Rook < Piece
  VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze # will need loop or recursion to get the full line
  def initialize(color, location)
    super(color, location)
    @moves = VALID_MOVES
    @type = 'rook'
  end

  def to_s
    @color == 'white' ? '♖' : '♜'
  end

  def check_moves
    next_moves = VALID_MOVES.map do |move|
      move.filter_map.with_index do |coord, index|
        coord + @location[index] unless (coord + @location[index]).negative? || (coord + @location[index]) > 7
      end
    end
    next_moves.keep_if { |move| move.length == 2 }
  end
end

# The Bishop subclass of Piece.
class Bishop < Piece
  VALID_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze # another loop/recursive method
  def initialize(color, location)
    super(color, location)
    @moves = VALID_MOVES
    @type = 'bishop'
  end

  def to_s
    @color == 'white' ? '♗' : '♝'
  end

  def check_moves
    next_moves = VALID_MOVES.map do |move|
      move.filter_map.with_index do |coord, index|
        coord + @location[index] unless (coord + @location[index]).negative? || (coord + @location[index]) > 7
      end
    end
    next_moves.keep_if { |move| move.length == 2 }
  end
end

# The Knight subclass of Piece.
class Knight < Piece
  VALID_MOVES = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]].freeze
  def initialize(color, location)
    super(color, location)
    @moves = VALID_MOVES
    @type = 'knight'
  end

  def to_s
    @color == 'white' ? '♘' : '♞'
  end

  def check_moves
    next_moves = VALID_MOVES.map do |move|
      move.filter_map.with_index do |coord, index|
        coord + @location[index] unless (coord + @location[index]).negative? || (coord + @location[index]) > 7
      end
    end
    next_moves.keep_if { |move| move.length == 2 }
  end
end

# The Pawn subclass of Piece.
class Pawn < Piece
  VALID_MOVES = [[-1, 0]].freeze # either allow for en passant and first move here or add methods for those separately
  def initialize(color, location)
    super(color, location)
    @moves = VALID_MOVES
    @type = 'pawn'
  end

  def to_s
    @color == 'white' ? '♙' : '♟'
  end

  def check_moves
    next_moves = VALID_MOVES.map do |move|
      move.filter_map.with_index do |coord, index|
        coord + @location[index] unless (coord + @location[index]).negative? || (coord + @location[index]) > 7
      end
    end
    next_moves.keep_if { |move| move.length == 2 }
  end
end

# def check_moves(piece)
  # next_moves = piece.moves.map do |move|
    # move.filter_map.with_index do |coord, index|
      # coord + @location[index] unless (coord + @location[index]).negative? || (coord + @location[index]) > 7
    # end
  # end
  # next_moves.keep_if { |move| move.length == 2 }
# end
