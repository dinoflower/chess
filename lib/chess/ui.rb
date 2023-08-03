# frozen_string_literal: true

# A module to contain prompts and print commands.
module UI
  def get_name(color)
    puts "#{color.capitalize} player, please enter your name:"
    gets.chomp.capitalize
  end

  def player_input
    piece_prompt
  end

  def select_piece
    loop do
      puts 'Please enter the location in algabraic notation:'
      loc = gets.chomp
      legal_location = conv_loc(loc) if /[a-h][1-8]/.match?(loc) && loc.length == 2
      return legal_location if legal_location
    end
  end

  def select_new
    loop do
      promotion_prompt
      piece = gets.chr.upcase
      return piece if /[QRBN]/.match?(piece)

      puts 'Please choose a valid promotion piece.'
    end
  end

  def conv_loc(alg)
    [(alg[1].to_i - 8).abs, alg[0].tr('a-h', '0-7').to_i]
  end
end

# TODO: #save and #quit will go here with the #save method then calling Serializer
# likely also a #resign method
