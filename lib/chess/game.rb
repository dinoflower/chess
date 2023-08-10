# frozen_string_literal: true

require_relative 'ui'

# This class instantiates a single instance (one game) of chess.
class Game
  include UI

  def initialize(board: arrange_board, wh_player: nil, bl_player: nil)
    @board = board
    @grid = board.grid
    @wh_player = wh_player
    @bl_player = bl_player
    @current_player = nil
  end

  def self.load_game
    saved = UI.load_save
    saved.play_game
  end

  def start_game
    intro
    @wh_player = create_player('white')
    @bl_player = create_player('black')
    @current_player = @wh_player
    play_game
  end

  def play_game
    loop do
      game_turn
      break if game_over?

      change_players
    end
    declare_winner
  end

  def game_turn
    input = prompt_player(@current_player.name)
    case input
    when 'help' then help
    when 'resign' then resign(@current_player.name)
    when 'save' then UI.save_game(self)
    else play_turn(input)
    end
  end

  private

  def play_turn(input)
    if input == 'castle'
      @current_player.castle_turn
    else
      player_piece = conv_loc(input)
      @current_player.normal_turn(player_piece)
    end
  end

  def game_over?
    player_in_check
    return false unless opponent.in_check

    res = opponent.mated?
    puts check_warning unless res

    res
  end

  def change_players
    @current_player = opponent
  end

  def opponent
    @current_player.color == 'white' ? @bl_player : @wh_player
  end

  def create_player(color)
    Player.new(color: color, name: ask_name(color), board: @board, grid: @grid, game: self)
  end

  def arrange_board
    Board.new
  end

  def player_in_check
    opponent.in_check = if opponent.checked?(@current_player.color, opponent.color)
                          true
                        else
                          false
                        end
  end
end
