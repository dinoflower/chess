# frozen_string_literal: true

# A module to contain piece and move validation, along with helper methods.
module MoveChecker
  # TODO: clean up
  def check_valid(color, start, finish)
    if check_piece(color, start, finish).nil?
      puts 'Please make a valid move.'
      play_turn
    elsif king_into_check?(start, finish)
      puts 'Illegal move: The king would be in check.'
      play_turn
    else
      @board.make_play(start, finish)
    end
  end

  def king_into_check?(start, finish)
    @board.test_move(start, finish)
    checked?(opp_color, @color)
    # return value doesn't work now duh
    @board.reset_move
  end

  # converts location arrays to pieces on the board to call #check_path
  def check_piece(color, start, finish)
    piece = simplify_piece(start)
    target = simplify_piece(finish)
    piece.check_path(color, target, finish)
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

  def off_board(temp_location)
    temp_location.any? { |coord| coord.negative? || coord > 7 }
  end

  def opposite?(color)
    @color != color
  end

  def simplify_piece(array)
    @grid[array[0]][array[1]]
  end
end
