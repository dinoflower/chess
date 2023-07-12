# frozen_string_literal: true

# A module to print a tidy board and messages.
module Display
  def print_board
    print "   a  b  c  d  e  f  g  h\n"
    print_rows
  end

  def print_rows
    @grid.each_with_index do |row, i|
      print "#{(i - 8).abs} "
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

    space.color == 'white' ? 97 : 30
  end

  def background_color(row_index, index)
    (row_index + index).even? ? 47 : 100
  end

  def symbol(space)
    return '   ' if space.nil?

    " #{space.symbol} "
  end

  # def intro
    # puts <<~HEREDOC
      # Welcome to Chess!

      # All standard rules apply, including castling, en passant, and promotion, but
      # there is no timer. Type SAVE instead of making a move to save and exit your game.

      # Indicate the piece you would like to move by typing its location followed by the
      # location of your target square.

    # HEREDOC
  # end
end
