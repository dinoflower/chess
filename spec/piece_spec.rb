# frozen_string_literal: true

require_relative '../lib/chess/piece'

describe Piece do
  describe '#check_moves' do
    it 'returns an array of moves' do
      color = 'white'
      location = [6, 3]
      check_pawn = Pawn.new(color, location)
      expect(check_pawn.check_moves).to be_a(Array)
    end
  end
end
