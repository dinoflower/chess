# frozen_string_literal: true

# A module to contain castling logic.
module Castle
  WHITE_KS = [[7, 5], [7, 6]].freeze
  WHITE_QS = [[7, 1], [7, 2], [7, 3]].freeze
  BLACK_KS = [[0, 5], [0, 6]].freeze
  BLACK_QS = [[0, 1], [0, 2], [0, 3]].freeze
  def castle
    if eligible?
      select_castle == 'K' ? short_castle : long_castle
    elsif !@castlable
      castle_eligibility_warning
    elsif @in_check
      castle_check_warning
    end
  end

  def eligible?
    @castlable && !@in_check
  end

  def short_castle
    if rook_moved?('short')
      rook_moved_warning
    elsif occ_between_short?
      castling_obstructed_warning
    elsif king_check_short?
      through_into_warning
    else
      short_move(find_king(@color))
    end
  end

  def long_castle
    if rook_moved?('long')
      rook_moved_warning
    elsif occ_between_long?
      castling_obstructed_warning
    elsif king_check_long?
      through_into_warning
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
    king_moves = @color == 'white' ? WHITE_QS.drop(1) : BLACK_QS.drop(1)
    king_moves.any? { |coord| king_into_check?(find_king(@color), coord) }
  end

  def short_move(king)
    @color == 'white' ? @board.make_play(king, [7, 6]) : @board.make_play(king, [0, 6])
    move_rook_short(@color)
  end

  def long_move(king)
    @color == 'white' ? @board.make_play(king, [7, 2]) : @board.make_play(king, [0, 2])
    move_rook_long(@color)
  end

  def move_rook_short(color)
    case color
    when 'white'
      @board.make_play([7, 7], [7, 5])
      @current_piece = [7, 5]
    when 'black'
      @board.make_play([0, 7], [0, 5])
      @current_piece = [0, 5]
    end
  end

  def move_rook_long(color)
    case color
    when 'white'
      @board.make_play([7, 0], [7, 3])
      @current_piece = [7, 3]
    when 'black'
      @board.make_play([0, 0], [0, 3])
      @current_piece = [0, 3]
    end
  end
end
