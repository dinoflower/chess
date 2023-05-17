# frozen_string_literal: true

# A module to contain prompts and print commands.
module UI
  def print_board
    print "    0 1 2 3 4 5 6 7\n"
    print "    _ _ _ _ _ _ _ _\n"
    @grid.each_with_index do |row, i|
      print "#{i}: |", row.map { |square| square.nil? ? '_' : square.symbol }.join('|'), "|\n"
    end
  end

  def get_name(color)
    puts "#{color.capitalize} player, please enter your name:"
    gets.chomp.capitalize
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

# TODO: implement color/highlighting
