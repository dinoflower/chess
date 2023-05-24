# frozen_string_literal: true

require_relative 'game'
require_relative 'move_checker'
require_relative 'ui'

# This class represents a (black or white) chess player.
class Player
  include MoveChecker
  include UI
  attr_reader :color

  def initialize(**opts)
    @color = opts[:color]
    @name = opts[:name]
    @board = opts[:board]
    @grid = opts[:grid]
    @game = opts[:game]
    @current_piece = nil
  end

  def to_s
    "#{@color.capitalize}, #{@name}"
  end

  def play_turn
    puts "#{@name}, your go."
    @current_piece = choose_piece
    print_board
    target_space = choose_target
    check_nil(@current_piece, target_space)
    print_board
  end

  # checks to see if player chose 1. a piece 2. of theirs
  def choose_piece
    loop do
      piece = [select_row, select_column]
      chosen_piece = piece unless simplify_piece(piece).nil? || simplify_piece(piece).color != @color
      return chosen_piece if chosen_piece

      puts 'Please choose one of YOUR pieces.'
    end
  end
end
