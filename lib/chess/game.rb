# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'piece'

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

  def set_board
    ChessSet.new
  end

  def create_player(color)
    puts "#{color.capitalize} player, please enter your name:"
    name = gets.chomp.capitalize
    Player.new(color, name)
  end

  def print_board
    @set.print_board
  end

  def play_game
    print_board
    play_turn
  end

  private

  def change_players
    @current_player.color == 'white' ? @bl_player : @wh_player
  end

  def play_turn
    current_piece = choose_piece
    puts simplify_piece(current_piece).type.to_s
    target_space = choose_target
    check_nil(current_piece, target_space)
    print_board
    @current_player = change_players
  end

  def check_nil(start, finish)
    if check_path(start, finish).nil?
      puts 'Please make a valid move.'
      play_turn
    else
      move_piece(start, finish)
    end
  end

  def check_path(start, finish)
    complex_pieces = %w[queen rook bishop]
    if simplify_piece(start).type == complex_pieces.any?
      # do the recursion
    else
      check_simple(start, finish)
    end
  end

  def move_piece(start, finish)
    @set.move_piece(start, finish)
  end

  def check_simple(start, finish)
    piece = simplify_piece(start)
    target = simplify_piece(finish)
    avail_moves = piece.check_moves
    return unless avail_moves.any?(finish)

    return finish if target.nil? || target.opposite?(piece.color)
  end

  def choose_piece
    loop do
      piece = [select_row, select_column]
      chosen_piece = piece if simplify_piece(piece).color == @current_player.color
      return chosen_piece if chosen_piece

      puts 'Please choose one of YOUR pieces.'
    end
  end

  def choose_target
    [select_row, select_column]
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

  def simplify_piece(array)
    @set.simplify_piece(array)
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
