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
    @guesses = []
  end

  private

  def increment_turn
    @turn += 1
  end

  def game_over?
    @game_over
  end

  def make_guess; end

  def take_turn; end

  def guess_is_correct?
    @guesses[-1] == @code
  end

  def end_turn
    increment_turn
    @game_over = true if guess_is_correct?
  end

  public

  def start_game
    take_turn until game_over?
  end
end
