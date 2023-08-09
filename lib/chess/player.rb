# frozen_string_literal: true

require_relative 'move_checker'
require_relative 'piece_finder'
require_relative 'ui'
require_relative 'castle'
require 'pry-byebug'

# This class represents a human chess player.
class Player
  include MoveChecker
  include UI
  include PieceFinder
  include Castle
  attr_accessor :in_check
  attr_reader :color, :name, :previous_piece

  def initialize(**opts)
    @color = opts[:color]
    @name = opts[:name]
    @board = opts[:board]
    @grid = opts[:grid]
    @current_piece = nil
    @previous_piece = nil
    @in_check = false
    @castlable = true
  end

  def to_s
    "#{@color.capitalize}, #{@name}"
  end

  def play_turn(opt = prompt_player(@name))
    case opt
    when 'castle' then castle
    when 'help' then help
    when 'resign' then resign(@name)
    # when 'save' then save
    else normal_turn(conv_loc(opt))
    end
  end

  def normal_turn(move)
    @current_piece = verify_piece(move)
    print_board
    target_space = choose_target
    check_valid(@current_piece, target_space)
    end_turn
  end

  def castle_turn
    castle
    end_turn
  end

  def checked?(color, target_color, piece_list = find_player_pieces(color))
    king = find_king(target_color)
    piece_list.any? { |piece| check_piece(piece.location, king) }
  end

  def mated?
    piece_list = all_next_moves(find_player_pieces(@color))
    moves = move_array(piece_list)
    moves.keep_if { |start, target_loc| check_piece(start, target_loc) }
    moves.all? do |start, target_loc|
      king_into_check?(start, target_loc)
    end
  end

  private

  def end_turn
    can_castle?
    pass_turn
  end

  def can_castle?
    rooks = find_rooks(@color).map { |rook| simplify_piece(rook) }
    return unless rooks.all?(&:moved) || simplify_piece(find_king(@color)).moved

    @castlable = false
  end

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

  def opp_color
    @color == 'white' ? 'black' : 'white'
  end

  def pass_turn
    @previous_piece = @current_piece
    @current_piece = nil
  end
end
