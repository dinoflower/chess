# frozen_string_literal: true

require 'yaml'
require_relative 'display'

# A module to contain prompts and print commands.
module UI
  include Display
  OPTIONS = %w[castle help resign save].freeze
  def ask_name(color)
    puts "#{color.capitalize} player, please enter your name:"
    gets.chomp
  end

  def prompt_player(name)
    turn_prompt(name)
    input_move
  end

  def input_move
    loop do
      input = gets.chomp
      return input if valid_input?(input)

      input_warning
    end
  end

  def select_piece
    loop do
      input = gets.chomp.downcase
      legal_location = conv_loc(input) if valid_move?(input)
      return legal_location if legal_location
    end
  end

  def select_new
    loop do
      promotion_prompt
      piece = gets.chr.upcase
      return piece if /[QRBN]/.match?(piece)

      piece_warning
    end
  end

  def select_castle
    loop do
      puts 'Please choose short (kingside) or long (queenside) by typing "K" or "Q."'
      side = gets.chr.upcase
      return side if /[QK]/.match?(side)

      input_warning
    end
  end

  def conv_loc(alg)
    [(alg[1].to_i - 8).abs, alg[0].tr('a-h', '0-7').to_i]
  end

  def valid_input?(input)
    OPTIONS.include?(input) || (/[a-h][1-8]/.match?(input) && input.length == 2)
  end

  def valid_move?(input)
    /[a-h][1-8]/.match?(input) && input.length == 2
  end

  def self.save_game(game)
    yaml = Psych.dump(game)
    Dir.mkdir('data') unless Dir.exist?('data')
    puts 'Name your save file:'
    extension = $stdin.gets.chomp.gsub(/\W/, '')
    File.open("data/#{extension}.yaml", 'w') { |save_file| save_file.puts yaml }
    puts 'Thank you for playing. See you next time!'
    exit
  end

  def self.load_save
    puts 'Please choose your save file:'
    Dir.each_child('data') { |x| puts x.delete_suffix('.yaml') }
    save_name = $stdin.gets.chomp.gsub(/\W/, '')
    f = File.new("data/#{save_name}.yaml")
    yaml = f.read
    Psych.safe_load(
      yaml, permitted_classes: [Game, Player, Board, Piece, Bishop, King, Knight, Pawn, Queen, Rook], aliases: true
    )
  end
end
