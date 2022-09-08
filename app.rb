# frozen_string_literal: false

require './peg'
require './row'

# Game stores game state, manages game loop
class Game
  COLORS = %w[Blue Red Orange Yellow Green Purple].freeze

  def initialize
    @turn = 1
    @code = []
    4.times { @code.push(COLORS.sample) }
  end
end
