# frozen_string_literal: true

# A module to contain piece and move validation.
module MoveChecker
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

  def choose_target
    puts 'Select your destination space:'
    [select_row, select_column]
  end

  def check_nil(start, finish)
    if check(start, finish).nil?
      puts 'Please make a valid move.'
      play_turn
    else
      @board.move_piece(start, finish)
    end
  end

  def check(start, finish)
    piece = simplify_piece(start)
    target = simplify_piece(finish)
    piece.check_path(target, finish)
  end

  def simplify_piece(array)
    @grid[array[0]][array[1]]
  end

  def square_empty?(location)
    @board[location[0]][location[1]].nil?
  end
end
