# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

# This class instantiates a single instance (one game) of chess.
class Game
  attr_reader :wh_player, :bl_player, :current_player

  def initialize
    @board = Board.new
    @wh_player = nil
    @bl_player = nil
    @current_player = @wh_player
  end

  def play_game
    intro
    set_players
    @board.print_board
  end

  def set_players
    @wh_player = create_player('white')
    @bl_player = create_player('black')
  end

  def create_player(color)
    puts 'Please enter your name:'
    name = gets.chomp.capitalize
    Player.new(color, name)
  end

  # def play_turn
    # current_piece = select_piece # then figure out where it wants to go
  # end

  # def select_piece
    # piece = gets.chomp
    # legal_piece = @current_player.verify_input(piece) if piece.match?(/[a-h][1-8]/) && piece.length == 2
    # return legal_piece if legal_piece
  # end

  def intro
    puts <<~HEREDOC
      Welcome to Chess!

      All standard rules apply, including castling, en passant, and promotion, but
      there is no timer. Type SAVE instead of making a move to save and exit your game.

      Indicate the piece you would like to move by typing its location in algebraic
      notation (e.g. 'e2') followed by your target square (e.g. 'e4').

      White plays first.

    HEREDOC
  end
end
