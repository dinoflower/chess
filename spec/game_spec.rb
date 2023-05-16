# frozen_string_literal: true

require_relative '../lib/chess/game'

describe Game do
  describe '#game_over?' do
    let(:white_player) { instance_double(Player, color: 'white') }
    let(:black_player) { instance_double(Player, color: 'black') }
    subject(:over_game) { described_class.new(wh_player: white_player, bl_player: black_player) }

    context 'when the King is not checkmated' do
      before do
        board = instance_variable_get(:@board)
        current_player = over_game.instance_variable_get(:@current_player)
        allow(current_player).to receive(:color).and_return('white')
        allow(board).to receive(:checkmate?).and_return(false)
      end
      it 'returns false' do
        expect(over_game.game_over?).to be false
      end
    end

    context 'when the King is checkmated' do
      before do
        board = instance_variable_get(:@board)
        current_player = over_game.instance_variable_get(:@current_player)
        allow(current_player).to receive(:color).and_return('white')
        allow(board).to receive(:checkmate?).and_return(true)
      end
      it 'returns true' do
        expect(over_game.game_over?).to be true
      end
    end
  end
end
