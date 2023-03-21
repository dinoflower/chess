# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'piece'

# This class instantiates a single instance (one game) of chess.
class Game
  attr_reader :wh_player, :bl_player, :current_player, :board

  def initialize
    @board = Board.new
    @wh_player = nil
    @bl_player = nil
    @current_player = nil
  end

  def play_game
    intro
    set_players
    @board.print_board
    play_turn
  end

  def set_players
    @wh_player = create_player('white')
    @bl_player = create_player('black')
    @current_player = @wh_player
  end

  def create_player(color)
    puts 'Please enter your name:'
    name = gets.chomp.capitalize
    Player.new(color, name)
  end

  def play_turn
    current_piece = choose_piece
    puts @board.board[current_piece[0]][current_piece[1]].type.to_s
    # TODO: add "undo" option here (on #current_piece?) if the output is not what the player wanted
    target_space = choose_target
    check_path(current_piece, target_space)
    @board.print_board
  end

  def check_path(start, finish)
    complex_pieces = %w[queen rook bishop]
    move = if @board.board[start[0]][start[1]].type == complex_pieces.any?
             # do the recursion
           else
             check_simple(start, finish)
           end
    @board.move_piece(start, move) unless move.empty?
  end

  def check_simple(start, finish)
    piece = @board.board[start[0]][start[1]]
    target = @board.board[finish[0]][finish[1]]
    avail_moves = piece.check_moves
    return unless avail_moves.any? == finish # problem appears to be here

    return finish if target.nil? || target.opposite?(piece.color)

    'Please choose a valid move.'
  end

  def choose_piece
    loop do
      piece = [select_row, select_column]
      chosen_piece = piece if @board.board[piece[0]][piece[1]].color == @current_player.color
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

  def intro
    puts <<~HEREDOC
      Welcome to Chess!

      All standard rules apply, including castling, en passant, and promotion, but
      there is no timer. Type SAVE instead of making a move to save and exit your game.

      Indicate the piece you would like to move by typing its location followed by the
      location of your target square.

      White plays first.

    HEREDOC
  end
end
