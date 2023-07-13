# frozen_string_literal: true

# A module to contain piece and move validation.
module MoveChecker
  # TODO: remove #move_piece call - call elsewhere
  def check_valid(player, start, finish)
    if check(player, start, finish).nil?
      puts 'Please make a valid move.'
      play_turn
    else
      @board.move_piece(start, finish)
    end
  end

  # converts location arrays to pieces on the board to call #check_path
  def check(player, start, finish)
    piece = simplify_piece(start)
    target = simplify_piece(finish)
    piece.check_path(player, target, finish)
  end

  # returns an array of all spaces on the board one "step" from current location
  def check_moves(moves)
    next_moves = moves.map do |move|
      move.filter_map.with_index do |coord, index|
        coord + @location[index] unless (coord + @location[index]).negative? || (coord + @location[index]) > 7
      end
    end
    next_moves.keep_if { |move| move.length == 2 }
  end

  def opposite?(player_color)
    @color != player_color
  end

  def simplify_piece(array)
    @grid[array[0]][array[1]]
  end

  def square_empty?(location)
    @board[location[0]][location[1]].nil?
  end
end
