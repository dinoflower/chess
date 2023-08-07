# frozen_string_literal: true

# A module to contain castling logic.
module Castle
  WHITE_KS = [[7, 5], [7, 6]].freeze
  WHITE_QS = [[7, 1], [7, 2], [7, 3]].freeze
  BLACK_KS = [[0, 5], [0, 6]].freeze
  BLACK_QS = [[0, 1], [0, 2], [0, 3]].freeze
  def castle
    if !@castlable
      puts 'You are no longer eligible to castle. Please make another move.'
    elsif @in_check
      puts 'You may not castle while your king is in check.'
    else
      select_castle == 'K' ? short_castle : long_castle
    end
  end

  def short_castle
    if rook_moved?('short')
      puts 'That rook has previously moved.'
    elsif occ_between_short?
      puts 'There are pieces between your king and rook.'
    elsif king_check_short?
      puts 'The king would pass through or end in check.'
    else
      short_move(find_king(@color))
    end
  end

  def long_castle
    if rook_moved?('long')
      puts 'That rook has previously moved.'
    elsif occ_between_long?
      puts 'There are pieces between your king and rook.'
    elsif king_check_long?
      puts 'The king would pass through or end in check.'
    else
      long_move(find_king(@color))
    end
  end

  def rook_moved?(side)
    case side
    when 'short'
      @color == 'white' ? simplify_piece([7, 7]).moved : simplify_piece([0, 7]).moved
    when 'long'
      @color == 'white' ? simplify_piece([7, 0]).moved : simplify_piece([0, 0]).moved
    end
  end

  def occ_between_short?
    if @color == 'white'
      WHITE_KS.any? { |coord| occupied(coord) }
    else
      BLACK_KS.any? { |coord| occupied(coord) }
    end
  end

  def occ_between_long?
    if @color == 'white'
      WHITE_QS.any? { |coord| occupied(coord) }
    else
      BLACK_QS.any? { |coord| occupied(coord) }
    end
  end

  def king_check_short?
    if @color == 'white'
      WHITE_KS.any? { |coord| king_into_check?(find_king(@color), coord) }
    else
      BLACK_KS.any? { |coord| king_into_check?(find_king(@color), coord) }
    end
  end

  def king_check_long?
    king_moves = if @color == 'white'
                   WHITE_QS.drop(1)
                 else
                   BLACK_QS.drop(1)
                 end
    king_moves.any? { |coord| king_into_check?(find_king(@color), coord) }
  end

  def short_move(king)
    @color == 'white' ? @board.make_play(king, [7, 6]) : @board.make_play(king, [0, 6])
    @color == 'white' ? @board.make_play([7, 7], [7, 5]) : @board.make_play([0, 7], [0, 5])
  end

  def long_move(king)
    @color == 'white' ? @board.make_play(king, [7, 2]) : @board.make_play(king, [0, 2])
    @color == 'white' ? @board.make_play([7, 0], [7, 3]) : @board.make_play([0, 0], [0, 3])
  end
end
