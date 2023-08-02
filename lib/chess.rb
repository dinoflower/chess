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

game = Game.new
game.play_game
