# frozen_string_literal: true

require_relative 'game'

# This class represents a (black or white) chess player.
class Player
  attr_reader :color

  def initialize(color, name, set, game)
    @color = color
    @name = name
    @set = set
    @board = set.board
    @game = game
  end

  def to_s
    "#{@color.capitalize}, #{@name}"
  end

  def play_turn
    puts "#{@name}, your go."
    current_piece = choose_piece
    puts simplify_piece(current_piece).type.to_s
    target_space = choose_target
    check_nil(current_piece, target_space)
    print_board
  end

  # simplify_piece can currently return nil, causing error
  def choose_piece
    loop do
      piece = [select_row, select_column]
      chosen_piece = piece if simplify_piece(piece).color == @color
      return chosen_piece if chosen_piece

      puts 'Please choose one of YOUR pieces.'
    end
  end

  def choose_target
    puts 'Select your destination space.'
    [select_row, select_column]
  end

  def check_nil(start, finish)
    if check_path(start, finish).nil?
      puts 'Please make a valid move.'
      play_turn
    else
      move_piece(start, finish)
    end
  end

  def move_piece(start, target)
    piece = simplify_piece(start)
    piece.location = target
    @board[target[0]][target[1]] = piece
    @board[start[0]][start[1]] = nil
  end

  # this should belong to the pieces or a module, since it's checking type
  def check_path(start, finish)
    complex_pieces = %w[queen rook bishop]
    if simplify_piece(start).type == complex_pieces.any?
      # do the recursion
    else
      check_simple(start, finish)
    end
  end

  def check_simple(start, finish)
    piece = simplify_piece(start)
    target = simplify_piece(finish)
    avail_moves = piece.check_moves
    return unless avail_moves.any?(finish)

    return finish if target.nil? || target.opposite?(piece.color)
  end

  def select_row
    loop do
      puts 'Please enter the row/rank:'
      row = gets.chomp
      legal_row = row.to_i if row.match?(/[0-7]/) && row.length == 1
      return legal_row if legal_row

      puts 'Please choose a row/rank on the board.'
    end
  end

  def select_column
    loop do
      puts 'Please enter the column/file:'
      column = gets.chomp
      legal_column = column.to_i if column.match?(/[0-7]/) && column.length == 1
      return legal_column if legal_column

      puts 'Please choose a column/file on the board.'
    end
  end

  def simplify_piece(array)
    @board[array[0]][array[1]]
  end

  def print_board
    @set.print_board
  end
end
