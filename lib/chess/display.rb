# frozen_string_literal: true

require_relative 'warnings'

# A module to print a tidy board as well as prompts.
module Display
  include Warnings
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

  def clear_screen
    puts "\e[H\e[2J"
  end

  def turn_prompt(name)
    print_board
    puts "#{name}, your go."
  end

  def promotion_prompt
    puts <<~HEREDOC
      Your pawn has been promoted! Please choose your new piece:
      Queen: Q, Rook: R, Bishop: B, Knight: N
    HEREDOC
  end

  def declare_winner
    congrats = "Congratulations, #{@current_player.name}! You've checkmated #{opponent.name}'s king!"
    puts "\e[32m#{congrats}\e[0m"
  end

  def resign(name)
    resignation = "#{name} has graciously resigned."
    puts "\e[32m#{resignation}\e[0m"
    exit
  end

  def intro
    puts <<~HEREDOC
      Welcome to Chess!

      Indicate the piece you would like to move by typing its location (in
      algebraic notation) followed by the location of its destination square.
      Type CASTLE to castle your king instead.

      Type SAVE instead of making a move to save and exit your game.

      Type HELP if you need assistance. You may RESIGN to concede the game or
      declare it a draw.

    HEREDOC
  end

  def help
    puts <<~HEREDOC
      Use algebraic notation (e.g. e2) to first indicate the piece that you would
      like to move, followed by the destination square (e.g. e4).

      Type CASTLE to castle your king. If you are able to castle, you will be
      prompted to choose short (kingside) or long (queenside) by typing "K" or "Q."

      When prompted to choose your promotion piece, type "Q" for Queen, "R" for Rook,
      "B" for Bishop, or "N" for Knight.

      Type SAVE to save and exit your game. Type RESIGN to resign.
    HEREDOC
    game_turn
  end
end
