# frozen_string_literal: true

require_relative '../lib/chess/move_checker'

describe MoveChecker do
  let(:dummy_class) { Class.new { extend MoveChecker } }

  describe 'move_array' do
    it 'converts a hash to an array with no empty sub-arrays' do
      piece_list = { [0, 0] => [[1, 0], [2, 0]], [0, 1] => [], [0, 2] => [[3, 0]] }
      expect(dummy_class.move_array(piece_list)).to eql([[[0, 0], [1, 0]], [[0, 0], [2, 0]], [[0, 2], [3, 0]]])
    end
  end
end
