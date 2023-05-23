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

  def choose_piece
    loop do
      piece = [select_row, select_column]
      chosen_piece = piece unless simplify_piece(piece).nil? || simplify_piece(piece).color != @color
      return chosen_piece if chosen_piece

      puts 'Please choose one of YOUR pieces.'
    end
  end
end
