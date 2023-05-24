# frozen_string_literal: true

# A module to contain prompts and print commands.
module UI
  FILES = ['a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7].freeze
  RANKS = [8 => 0, 7 => 1, 6 => 2, 5 => 3, 4 => 4, 3 => 5, 2 => 6, 1 => 7].freeze

  def print_board
    print "   0  1  2  3  4  5  6  7\n"
    print_rows
  end

  def print_rows
    @grid.each_with_index do |row, i|
      print "#{i} "
      print_row(row, i)
      puts
    end
  end

  def print_row(row, index)
    row.each_with_index do |space, i|
      colorize_space(space, index, i)
    end
  end

  def colorize_space(space, row_index, index)
    bg_color = background_color(row_index, index)
    text_color = text_color(space)
    symbol = symbol(space)
    print_space(text_color, bg_color, symbol)
  end

  def print_space(text_color, bg_color, content)
    print "\e[#{text_color};#{bg_color}m#{content}\e[0m"
  end

  def text_color(space)
    return nil if space.nil?

    return 31 if space.location == @current_piece

    space.color == 'white' ? 39 : 30
  end

  def background_color(row_index, index)
    (row_index + index).even? ? 47 : 100
  end

  def symbol(space)
    return '   ' if space.nil?

    " #{space.symbol} "
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

  def convert_input(input); end

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

# TODO: implement traditional ranks and files
# TODO: #save and #quit will go here with the #save method then calling Serializer
# likely also a #resign method
