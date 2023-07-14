# frozen_string_literal: true

require_relative 'game'
require_relative 'move_checker'
require_relative 'ui'
require_relative 'display'

# This class represents a human chess player.
class Player
  include MoveChecker
  include UI
  include Display
  attr_reader :color, :name

  def initialize(**opts)
    @color = opts[:color]
    @name = opts[:name]
    @board = opts[:board]
    @grid = opts[:grid]
    @game = opts[:game]
    @current_piece = nil
    @previous_piece = nil
    # @castled = false
  end

  def to_s
    "#{@color.capitalize}, #{@name}"
  end

  # TODO: implement check for... check and checkmate
  def play_turn
    @current_piece = choose_piece
    print_board
    target_space = choose_target
    check_valid(self, @current_piece, target_space)
    pass_turn
  end

  # checks to see if player chose 1. a piece 2. of theirs
  def choose_piece
    loop do
      column = select_column
      row = select_row
      piece = [row, column]
      chosen_piece = piece unless simplify_piece(piece).nil? || simplify_piece(piece).color != @color
      return chosen_piece if chosen_piece

      puts 'Please choose one of your pieces to move.'
    end
  end

  def choose_target
    puts 'Select your destination space:'
    column = select_column
    row = select_row
    [row, column]
  end

  private

  def pass_turn
    @previous_piece = @current_piece
    @current_piece = nil
  end
end
