# frozen_string_literal: true

require_relative '../lib/chess/player'

describe Player do
  describe '#choose_piece' do
    piece_opts = { color: 'white', name: 'Horace', board: 'board', grid: 'grid', game: 'game' }
    subject(:player_piece) { described_class.new(piece_opts) }

    context "when the player chooses their opponent's piece once and then their own piece once" do
      before do
        allow(player_piece).to receive(:select_row).and_return(1, 6)
        allow(player_piece).to receive(:select_column).and_return(3)
      end
      it 'completes the loop and displays the error message once' do
        message = 'Please choose one of YOUR pieces.'
        allow(simplify_piece).to receive(:color).and_return('white')
        expect(player_piece).to receive(:puts).with(message).once
        player_piece.choose_piece
      end
    end
  end
end
