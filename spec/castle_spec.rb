# frozen_string_literal: true

require_relative '../lib/chess/castle'

describe Castle do
  let(:dummy_class) { Class.new { extend Castle } }
end
