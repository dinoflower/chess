# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

# This class instantiates a single instance (one game) of chess.
class Game
  def initialize(board: set_board, wh_player: nil, bl_player: nil)
    @board = board
    @grid = board.grid
    @wh_player = wh_player
    @bl_player = bl_player
    @current_player = nil
  end

  def play_game
    start_game
    # until game_over?
      @current_player.play_turn
      change_players
    # end
  end

  def start_game
    @wh_player = create_player('white')
    @bl_player = create_player('black')
    @current_player = @wh_player
    @board.print_board
  end

  def game_over?
    return false unless @board.checkmate?(opponent.color)
  end

  private

  def change_players
    @current_player = opponent
  end

  def opponent
    @current_player.color == 'white' ? @bl_player : @wh_player
  end

  def create_player(color)
    puts "#{color.capitalize} player, please enter your name:"
    name = gets.chomp.capitalize
    Player.new(color: color, name: name, board: @board, grid: @grid, game: self)
  end

  def set_board
    Board.new
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
