# frozen_string_literal: true

require_relative 'game'
require_relative 'move_checker'

# This class represents a (black or white) chess player.
class Player
  include MoveChecker
  attr_reader :color

  def initialize(**opts)
    @color = opts[:color]
    @name = opts[:name]
    @board = opts[:board]
    @grid = opts[:grid]
    @game = opts[:game]
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
    @board.print_board
  end

  def choose_piece
    loop do
      piece = [select_row, select_column]
      chosen_piece = piece unless simplify_piece(piece).nil? || simplify_piece(piece).color != @color
      return chosen_piece if chosen_piece

      puts 'Please choose one of YOUR pieces.'
    end
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
end
