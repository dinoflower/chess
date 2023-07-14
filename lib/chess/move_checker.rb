# frozen_string_literal: true

# A module to contain piece and move validation, along with helper methods.
module MoveChecker
  # TODO: remove #move_piece call - call in #play_turn maybe?
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

  # returns an array of all legal multi-step moves on the board
  def check_long_moves
    @moves.map do |move|
      avail_moves = []
      temp = shift(move, @location)
      until ally(temp) || off_board(temp)
        avail_moves << shift(move, temp)
        temp = shift(move, temp)
      end
      avail_moves
    end
  end

  def shift(move, coords)
    [move[0] + coords[0], move[1] + coords[1]]
  end

  def ally(coords)
    return false if square_empty?(location)

    simplify_piece(coords).color == @color
  end

  def off_board(temp_location)
    temp_location[0].negative? || temp_location > 7
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

# TODO: write a method that can check the possible moves of all pieces of the current player
# in order to see if the opposite player's king is threatened
