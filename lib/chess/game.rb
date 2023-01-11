# frozen_string_literal: true

require_relative 'player'

# This class enstantiates a single instance (one game) of chess.
class Game
  attr_reader :wh_player, :bl_player

  def initialize
    @wh_player = nil
    @bl_player = nil
  end

  def play_game
    intro
    set_players
  end

  def set_players
    @wh_player = Player.create_player('white')
    @bl_player = Player.create_player('black')
  end

  def intro
    puts <<~HEREDOC
      Welcome to Chess!

      All standard rules apply, including castling, en passant, and promotion, but
      there is no timer. Type SAVE instead of making a move to save your game.

      Indicate the piece you would like to move by typing its location in algebraic
      notation (e.g. 'e2') and then your target square (e.g. 'e4').

      White plays first.

    HEREDOC
  end
end
