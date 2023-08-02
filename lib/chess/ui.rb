# frozen_string_literal: true

# A module to contain prompts and print commands.
module UI
  def get_name(color)
    puts "#{color.capitalize} player, please enter your name:"
    gets.chomp.capitalize
  end

  def select_row
    loop do
      puts 'Please enter the row/rank:'
      row = gets.chomp
      legal_row = conv_row(row) if row.match?(/[1-8]/) && row.length == 1
      return legal_row if legal_row

      puts 'Please choose a row/rank on the board.'
    end
  end

  def select_column
    loop do
      puts 'Please enter the column/file:'
      column = gets.chomp
      legal_column = conv_column(column) if column.match?(/[a-h]/) && column.length == 1
      return legal_column if legal_column

      puts 'Please choose a column/file on the board.'
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

  def conv_row(num)
    (num.to_i - 8).abs
  end

  def conv_column(letter)
    letter.tr('a-h', '0-7').to_i
  end
end

# TODO: #save and #quit will go here with the #save method then calling Serializer
# possibly #undo as well
# likely also a #resign method
