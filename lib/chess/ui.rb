# frozen_string_literal: true

require 'pry-byebug'

# A module to contain prompts and print commands.
module UI
  def get_name(color)
    puts "#{color.capitalize} player, please enter your name:"
    gets.chomp.capitalize
  end

  def prompt_player
    turn_prompt
    input_move
  end

  def input_move
    loop do
      input = gets.chomp
      if option_input?(input)
        manage_prompts(input)
      elsif valid_move?(input)
        valid_input = conv_loc(input)
      end
      return valid_input if valid_input
    end
  end

  def select_piece
    loop do
      input = gets.chomp.downcase
      legal_location = conv_loc(input) if valid_move?(input)
      return legal_location if legal_location
    end
  end

  def manage_prompts(input)
    case input
    # when 'castle' then castle
    when 'help' then help
    # when 'resign' then resign
    # when 'save' then save
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

  def conv_loc(alg)
    [(alg[1].to_i - 8).abs, alg[0].tr('a-h', '0-7').to_i]
  end

  def valid_move?(input)
    /[a-h][1-8]/.match?(input) && input.length == 2
  end

  def option_input?(input)
    @options.include?(input)
  end
end

# TODO: #save and #quit will go here with the #save method then calling Serializer
# likely also a #resign method
