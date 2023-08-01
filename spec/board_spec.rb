# frozen_string_literal: true

require_relative '../lib/chess/board'

describe Board do
  describe '#move_piece' do
    let(:move_board) { described_class.new }

    before do
      start = [6, 4]
      finish = [4, 4]
      move_board.move_piece(start, finish)
    end

    it 'moves a piece from the original position' do
      start_space = move_board.grid[6][4]
      expect(start_space).to be_nil
    end

    it 'moves a piece to the new position' do
      target = move_board.grid[4][4]
      expect(target).not_to be_nil
    end

    it 'updates the location value of the piece' do
      target = move_board.grid[4][4]
      expect(target.location).to eq([4, 4])
    end
  end
end
