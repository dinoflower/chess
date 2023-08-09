# frozen_string_literal: true

# A module to contain the game's various colorized warning messages.
module Warnings
  def colorize_warning(warning)
    puts "\e[31m#{warning}\e[0m"
  end

  def input_warning
    colorize_warning('Please provide valid input.')
  end

  def piece_warning
    colorize_warning('Please choose a valid piece.')
  end

  def check_warning
    colorize_warning('Warning! King in check!')
  end

  def warn_and_retry(warning)
    puts "\e[31m#{warning}\e[0m"
    play_turn
  end

  def move_warning
    @current_piece = nil
    warn_and_retry('Please make a valid move.')
  end

  def into_check_warning
    @current_piece = nil
    warn_and_retry('Illegal move: Your king would be in check.')
  end

  def castle_eligibility_warning
    warn_and_retry('You are no longer eligible to castle. Please make another move.')
  end

  def castle_check_warning
    warn_and_retry('You may not castle while your king is in check.')
  end

  def rook_moved_warning
    warn_and_retry('That rook has previously moved.')
  end

  def castling_obstructed_warning
    warn_and_retry('There are pieces between your king and rook.')
  end

  def through_into_warning
    warn_and_retry('The king would pass through or end in check.')
  end
end
