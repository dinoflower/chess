# frozen_string_literal: true

# A module to contain piece and move validation, along with helper methods.
module MoveChecker
  # TODO: remove #move_piece call - call in #play_turn maybe?
  def check_valid(player, start, finish)
    if check_piece(player, start, finish).nil?
      puts 'Please make a valid move.'
      play_turn
    else
      @board.move_piece(start, finish)
    end
  end

  # converts location arrays to pieces on the board to call #check_path
  def check_piece(player, start, finish)
    piece = simplify_piece(start)
    target = simplify_piece(finish)
    piece.check_path(player, target, finish)
  end

  def shift(move, coords)
    [move[0] + coords[0], move[1] + coords[1]]
  end

  def ally(coords)
    return false if simplify_piece(coords).nil?

    simplify_piece(coords).color == @color
  end

  def off_board(temp_location)
    temp_location.any? { |coord| coord.negative? || coord > 7 }
  end

  def opposite?(player_color)
    @color != player_color
  end

  def simplify_piece(array)
    @grid[array[0]][array[1]]
  end
end
