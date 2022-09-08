# frozen_string_literal: false

require './peg'
require './row'

# Game stores game state, manages game loop
class Game
  PEGS = %w[Peg.new(Blue) Peg.new(Red) Peg.new(Orange) Peg.new(Yellow) Peg.new(Green) Peg.new(Purple)].freeze

  def initialize
    @game_over = false
    @turn = 1
    @code = []
    4.times { @code.push(PEGS.sample) }
  end

  private

  def increment_turn
    @turn += 1
  end

  def game_over?
    @game_over
  end

  public

  def start_game
    until game_over?

    end
  end
end
