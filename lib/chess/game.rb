# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'ui'
require_relative 'display'
require_relative 'move_checker'

# This class instantiates a single instance (one game) of chess.
class Game
  include UI
  include Display
  include MoveChecker

  def initialize(board: set_board, wh_player: nil, bl_player: nil)
    @board = board
    @grid = board.grid
    @wh_player = wh_player
    @bl_player = bl_player
    @current_player = nil
  end

  def play_game
    start_game
    until game_over?
      game_turn
      change_players
    end
    # declare_winner
  end

  # method will be private, currently public for testing purposes
  def game_over?
    # unless @board.checkmate?(opponent.color)
    false
  end

  private

  def start_game
    @wh_player = create_player('white')
    @bl_player = create_player('black')
    @current_player = @wh_player
  end

  def game_turn
    print_board
    puts "#{@current_player.name}, your go. Choose a piece to move."
    @current_player.play_turn
  end

  def change_players
    @current_player = opponent
  end

  def opponent
    @current_player.color == 'white' ? @bl_player : @wh_player
  end

  def create_player(color)
    Player.new(color: color, name: get_name(color), board: @board, grid: @grid, game: self)
  end

  def set_board
    Board.new
  end
end
