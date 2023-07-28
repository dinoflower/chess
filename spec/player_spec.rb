# frozen_string_literal: true

require_relative '../lib/chess/player'
require_relative '../lib/chess/move_checker'
require_relative '../lib/chess/piece_finder'
require_relative '../lib/chess/ui'

describe Player do
  describe '#mated?' do
    let(:mated_board) { double('board') }
    subject(:game_mated) do
      described_class.new(color: 'black', name: 'Mothman',
                          board: mated_board, grid: mated_board.grid, game: nil)
    end

    context 'when the player can make a move out of check' do
      it 'returns false' do
      end
    end

    context 'when the player cannot make a move out of check' do
      it 'returns true' do
      end
    end
  end
end
