# frozen_string_literal: true

require_relative '../lib/chess/player'

describe Player do
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

  describe '#move_piece' do
    subject(:move_player) { described_class.new }

    it 'moves the piece from the original square' do
      start = [6, 3]
      target = [4, 3]
      move_player.move_piece(start, target)
      expect(move_player.board[start[0]][start[1]]).to be_nil
    end

    it 'moves the piece to the target square' do
      start = [6, 3]
      target = [4, 3]
      piece_type = 'pawn'
      move_player.move_piece(start, target)
      expect(move_set.board[target[0]][target[1]].type).to eq(piece_type)
    end
  end
end
