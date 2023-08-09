# frozen_string_literal: true

require 'pry-byebug'

# A module to contain piece and move validation, along with helper methods.
module MoveChecker
  # should king_into_check be outside of the movement?
  def check_valid(start, target_loc)
    if simplify_piece(start).pawn? && en_passantable?(start, target_loc)
      move_en_passant(start, target_loc)
    elsif check_piece(start, target_loc).nil?
      move_warning
    elsif king_into_check?(start, target_loc)
      into_check_warning
    else
      @board.make_play(start, target_loc)
    end
  end

  def check_piece(start, target_loc)
    piece = simplify_piece(start)
    target_piece = simplify_piece(target_loc)
    piece.check_path(target_piece, target_loc)
  end

  def en_passantable?(start, target_loc)
    piece = simplify_piece(start)
    target_piece = simplify_piece(target_loc)
    return false unless target_piece.nil? && piece.check_moves(piece.captures).any?(target_loc)

    passed_square = [start[0], target_loc[1]]
    return false unless capture_en_passant?(passed_square)

    true
  end

  def capture_en_passant?(passed_square)
    return false unless occupied(passed_square) && simplify_piece(passed_square).pawn?
    return false if ally(passed_square)

    passed_piece = simplify_piece(passed_square)
    passed_piece.passable && @board.last_piece == passed_piece
  end

  def move_en_passant(start, target_loc)
    passed_square = [start[0], target_loc[1]]
    @grid[passed_square[0]][passed_square[1]] = nil
    @board.make_play(start, target_loc)
  end

  def king_into_check?(start, target_loc)
    @board.test_move(start, target_loc)
    result = checked?(opp_color, @color)
    @board.reset_move(start, target_loc)
    result
  end

  # creates hash of current locations with arr of possible next moves as value
  def all_next_moves(pieces)
    pieces.each_with_object({}) do |piece, piece_list|
      piece_list[piece.location] = piece.check_moves(piece.moves)
    end
  end

  # converts hash to array with no empty sub-arrays
  def move_array(piece_list)
    piece_list.flat_map do |piece, moves|
      moves.map { |move| [piece, move] }
    end
  end

  def shift(move, coords)
    [move[0] + coords[0], move[1] + coords[1]]
  end

  def occupied(coords)
    return false if simplify_piece(coords).nil?

    true
  end

  def ally(coords)
    return false if simplify_piece(coords).nil?

    simplify_piece(coords).color == @color
  end

  def off_board(temp_loc)
    temp_loc.any? { |coord| coord.negative? || coord > 7 }
  end

  def opposite?(color)
    @color != color
  end

  def simplify_piece(array)
    @grid[array[0]][array[1]]
  end
end
