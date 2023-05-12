# frozen_string_literal: true

# This class represents a generic chess piece for either (black or white) player.
class Piece
  attr_accessor :location
  attr_reader :color, :type, :symbol

  def initialize(**opts)
    @color = opts[:color]
    @location = opts[:location]
    @type = default_type
    @moves = valid_moves
  end

  def check_moves
    next_moves = @moves.map do |move|
      move.filter_map.with_index do |coord, index|
        coord + @location[index] unless (coord + @location[index]).negative? || (coord + @location[index]) > 7
      end
    end
    next_moves.keep_if { |move| move.length == 2 }
  end

  def opposite?(player_color)
    @color != player_color
  end

  private

  def default_type
    raise NotImplementedError
  end

  def valid_moves
    raise NotImplementedError
  end
end

# The King subclass of Piece.
class King < Piece
  VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  def initialize(**opts)
    @symbol = confirm_symbol(opts[:color])
    super
  end

  def check_path(player, target, finish)
    avail_moves = check_moves
    return unless avail_moves.any?(finish)

    return finish if target.nil? || target.opposite?(player.color)
  end

  private

  def default_type
    'king'
  end

  def valid_moves
    VALID_MOVES
  end

  def confirm_symbol(color)
    color == 'white' ? '♔' : '♚'
  end
end

# The Queen subclass of Piece.
class Queen < Piece
  VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  def initialize(**opts)
    @symbol = confirm_symbol(opts[:color])
    super
  end

  def check_path(player, target, finish); end

  private

  def default_type
    'queen'
  end

  def valid_moves
    VALID_MOVES
  end

  def confirm_symbol(color)
    color == 'white' ? '♕' : '♛'
  end
end

# The Rook subclass of Piece.
class Rook < Piece
  VALID_MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze # will need loop or recursion to get the full line
  def initialize(**opts)
    @symbol = confirm_symbol(opts[:color])
    super
  end

  def check_path(player, target, finish); end

  private

  def default_type
    'rook'
  end

  def valid_moves
    VALID_MOVES
  end

  def confirm_symbol(color)
    color == 'white' ? '♖' : '♜'
  end
end

# The Bishop subclass of Piece.
class Bishop < Piece
  VALID_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze # another loop/recursive method
  def initialize(**opts)
    @symbol = confirm_symbol(opts[:color])
    super
  end

  def check_path(player, target, finish); end

  private

  def default_type
    'bishop'
  end

  def valid_moves
    VALID_MOVES
  end

  def confirm_symbol(color)
    color == 'white' ? '♗' : '♝'
  end
end

# The Knight subclass of Piece.
class Knight < Piece
  VALID_MOVES = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]].freeze
  def initialize(**opts)
    @symbol = confirm_symbol(opts[:color])
    super
  end

  def check_path(player, target, finish)
    avail_moves = check_moves
    return unless avail_moves.any?(finish)

    return finish if target.nil? || target.opposite?(player.color)
  end

  private

  def default_type
    'knight'
  end

  def valid_moves
    VALID_MOVES
  end

  def confirm_symbol(color)
    color == 'white' ? '♘' : '♞'
  end
end

# The Pawn subclass of Piece.
class Pawn < Piece
  VALID_MOVES = [[-1, 0]].freeze # either allow for en passant and first move here or add methods for those separately
  def initialize(**opts)
    @symbol = confirm_symbol(opts[:color])
    super
  end

  def check_path(player, target, finish)
    avail_moves = check_moves
    return unless avail_moves.any?(finish)

    return finish if target.nil? || target.opposite?(player.color)
  end

  private

  def default_type
    'pawn'
  end

  def valid_moves
    VALID_MOVES
  end

  def confirm_symbol(color)
    color == 'white' ? '♙' : '♟'
  end
end

# post_initialize(opts) to send opts to subclasses instead of expecting them to send to Piece?
