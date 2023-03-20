# frozen_string_literal: true

require_relative '../lib/chess/board'

describe Board do
  describe '#move_piece' do
    subject(:move_board) { described_class.new }

    it 'moves the piece from the original square' do
      start = [6, 3]
      target = [4, 3]
      move_board.move_piece(start, target)
      expect(move_board.board[start[0]][start[1]]).to be_nil
    end

    it 'moves the piece to the target square' do
      start = [6, 3]
      target = [4, 3]
      piece_type = 'pawn'
      move_board.move_piece(start, target)
      expect(move_board.board[target[0]][target[1]].type).to eq(piece_type)
    end
  end
end
