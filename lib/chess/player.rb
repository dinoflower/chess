# frozen_string_literal: true

require_relative 'game'
require_relative 'move_checker'
require_relative 'ui'
require_relative 'display'
require_relative 'piece_finder'

# This class represents a human chess player.
class Player
  include MoveChecker
  include UI
  include Display
  include PieceFinder
  attr_accessor :in_check
  attr_reader :color, :name

  def initialize(**opts)
    @color = opts[:color]
    @name = opts[:name]
    @board = opts[:board]
    @grid = opts[:grid]
    @game = opts[:game]
    @current_piece = nil
    @previous_piece = nil
    @in_check = false
    # @castled = false
  end

  def to_s
    "#{@color.capitalize}, #{@name}"
  end

  def play_turn
    @current_piece = choose_piece
    print_board
    target_space = choose_target
    check_valid(@color, @current_piece, target_space)
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

  # determine whether target king is in check
  def checked?(color, target_color, piece_list = find_player_pieces(color))
    king = find_king(target_color)
    piece_list.each do |piece|
      return true unless check_piece(color, piece.location, king).nil?
    end
    false
  end

  # determine whether player's king has been checkmated
  def mated?
    # pieces = find_player_pieces(@color)
    # piece_list = pieces.each { |piece| piece.check_moves(piece.moves) }
    # rework that to give us a list of pieces (or their locations?) and the locations they can move to
    # then go through and test king_into_check...
    # ...on each piece's current location and possible end location
  end

  private

  def opp_color
    @color == 'white' ? 'black' : 'white'
  end

  def pass_turn
    @previous_piece = @current_piece
    @current_piece = nil
  end
end
