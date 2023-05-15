# frozen_string_literal: true

require_relative '../lib/chess/piece'

describe Piece do
  describe '#check_moves' do
    it 'returns an array of moves' do
      color = 'white'
      location = [6, 3]
      check_pawn = Pawn.new(color: color, location: location)
      expect(check_pawn.check_moves).to be_a(Array)
    end
  end

  describe '#check_path' do
    subject(:path_game) { described_class.new }

    context 'when there are no available moves' do
      before do
        allow(path_game).to receive(:check_simple).and_return
      end
    end
  end
end
