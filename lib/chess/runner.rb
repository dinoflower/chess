# frozen_string_literal: true

# The file in bin creates an instance of this class to run the game.
class Runner
  def initialize
    # @arguments = arguments
    # @stdin = stdin
    # @stdout = stdout
    @game = Game.new
  end

  def run
    # later, implement config for game load?
    # Config.in_stream = @stdin
    # Config.out_stream = @stdout
    # parse_options
    @game.play_game
  end

  # e.g. to start a new game or load a save?
  # def parse_options
    # options = OptionParser.new
    # options.banner = "Usage: chess [options]"
    # options.on('-h', '--help',          "Show this message")          { puts(options); exit }
    # options.parse!(@arguments)
  # end
end
