# frozen_string_literal: true

require_relative '../lib/chess/game'

describe Game do
  describe '#choose_piece' do
    subject(:game_piece) { described_class.new }

    context "when the player chooses their opponent's piece once and then their own piece once" do
      before do
        allow(game_piece).to receive(:select_row).and_return(1, 6)
        allow(game_piece).to receive(:select_column).and_return(3)
      end
      it 'completes the loop and displays the error message once' do
        message = 'Please choose one of YOUR pieces.'
        current_player = game_piece.instance_variable_get(:@current_player)
        allow(current_player).to receive(:color).and_return('white')
        expect(game_piece).to receive(:puts).with(message).once
        game_piece.choose_piece
      end
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
