# frozen_string_literal: true

require_relative 'chess/game'
require_relative 'chess/board'
require_relative 'chess/player'
require_relative 'chess/pieces/piece'
require_relative 'chess/pieces/king'
require_relative 'chess/pieces/queen'
require_relative 'chess/pieces/rook'
require_relative 'chess/pieces/bishop'
require_relative 'chess/pieces/knight'
require_relative 'chess/pieces/pawn'

if Dir.exist?('data') && !Dir.empty?('data')
  puts 'Would you like to load a saved game?'
  answer = $stdin.gets.chr.upcase
  answer == 'Y' ? Game.load_game : Game.new.start_game
else
  Game.new.start_game
end
