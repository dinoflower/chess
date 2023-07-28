# frozen_string_literal: true

require_relative '../lib/chess/game'

describe Game do
  describe '#game_over?' do
    let(:over_player) { double('player') }
    subject(:over_game) { described_class.new(wh_player: over_player) }

    context 'when the King is not in check' do
      it 'does not call #mated?' do
        current_player = over_game.current_player
        allow(current_player).to receive(:in_check).and_return(false)
        expect(current_player).not_to receive(:mated?)
        over_game.game_over?
      end
    end

    context 'when the King is in check but not checkmated' do
      before do
        current_player = over_game.current_player
        allow(current_player).to receive(:in_check).and_return(true)
        allow(current_player).to receive(:mated?).and_return(false)
      end
      it 'is not game over' do
        expect(over_game).to_not be_game_over
      end
    end

    context 'when the King is checkmated' do
      before do
        current_player = over_game.current_player
        allow(current_player).to receive(:in_check).and_return(true)
        allow(current_player).to receive(:mated?).and_return(true)
      end
      it 'returns true' do
        expect(over_game).to be_game_over
      end
    end
  end
end
