# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

# This class instantiates a single instance (one game) of chess.
class Game
  def initialize(set: set_board,
                 wh_player: create_player('white'),
                 bl_player: create_player('black'))
    @set = set
    @board = set.board
    @wh_player = wh_player
    @bl_player = bl_player
    @current_player = wh_player
  end

  def play_game
    print_board
    @current_player.play_turn
    @current_player = change_players
  end

  def move_piece(start, finish)
    @set.move_piece(start, finish)
  end

  def simplify_piece(array)
    @set.simplify_piece(array)
  end

  def print_board
    @set.print_board
  end

  private

  def change_players
    @current_player.color == 'white' ? @bl_player : @wh_player
  end

  def create_player(color)
    puts "#{color.capitalize} player, please enter your name:"
    name = gets.chomp.capitalize
    Player.new(color, name, self)
  end

  def set_board
    ChessSet.new
  end

  # def intro
    # puts <<~HEREDOC
      # Welcome to Chess!

      # All standard rules apply, including castling, en passant, and promotion, but
      # there is no timer. Type SAVE instead of making a move to save and exit your game.

      # Indicate the piece you would like to move by typing its location followed by the
      # location of your target square.

      # White plays first.

    # HEREDOC
  # end
end
