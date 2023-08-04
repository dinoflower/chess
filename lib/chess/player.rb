# frozen_string_literal: true

require_relative 'display'
require_relative 'move_checker'
require_relative 'piece_finder'
require_relative 'ui'
require 'pry-byebug'

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
    @current_piece = nil
    @previous_piece = nil
    @in_check = false
    @castled = false
  end

  def to_s
    "#{@color.capitalize}, #{@name}"
  end

  def play_turn(move)
    @current_piece = verify_piece(move)
    print_board
    target_space = choose_target
    check_valid(@color, @current_piece, target_space)
    pass_turn
  end

  # checks to see if player chose 1. a piece 2. of theirs
  def verify_piece(piece)
    chosen_piece = piece unless simplify_piece(piece).nil? || simplify_piece(piece).color != @color
    return chosen_piece if chosen_piece

    piece_warning
    verify_piece(select_piece)
  end

  def choose_target
    puts 'Select your destination space:'
    select_piece
  end

  # determine whether target king is in check
  def checked?(color, target_color, piece_list = find_player_pieces(color))
    king = find_king(target_color)
    piece_list.any? { |piece| check_piece(color, piece.location, king) }
  end

  # determine whether player's king has been checkmated
  def mated?
    piece_list = all_next_moves(find_player_pieces(@color))
    moves = move_array(piece_list)
    moves.keep_if { |start, target| check_piece(@color, start, target) }
    moves.all? do |start, target|
      king_into_check?(start, target)
    end
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
