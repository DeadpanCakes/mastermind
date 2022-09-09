# frozen_string_literal: false

require './peg'

# AI to make informed guesses
class AI
  OPTIONS = [Peg.new('B'), Peg.new('P'), Peg.new('O'), Peg.new('Y'), Peg.new('G'), Peg.new('R')].freeze

  def initialize
    @eliminated = [[], [], [], []]
    @guess_history = []
    @hints = []
  end

  private

  def pick_peg(eliminated)
    OPTIONS.reject { |option| eliminated.include?(option) }.sample
  end

  def handle_correct_colors
    wrong_colors = OPTIONS.reject { |option| @guess_history[-1].include?(option) }
    @eliminated.each { |arr| arr.concat(wrong_colors) }
  end

  def handle_wrong_colors
    wrong_colors = @guess_history[-1].uniq
    @eliminated.each { |arr| arr.concat(wrong_colors) }
  end

  def process_hint(hint)
    handle_correct_colors if hint[:wrong].zero?
    handle_wrong_colors if hint[:wrong] == 4
  end

  public

  def init_guesses
    [[OPTIONS[0], OPTIONS[0], OPTIONS[1], OPTIONS[1]],
     [OPTIONS[2], OPTIONS[2], OPTIONS[3], OPTIONS[3]],
     [OPTIONS[4], OPTIONS[4], OPTIONS[5], OPTIONS[5]]]
  end

  def store_guess(guess)
    @guess_history.push(guess.map { |icon| Peg.new(icon) })
  end

  def take_turn(turn)
    if turn > 3
      guess = []
      @eliminated.each { |spot| guess.push(pick_peg(spot)) }
      store_guess(guess.map(&:icon))
      guess.map(&:icon).join
    else
      guess = init_guesses[turn - 1].map(&:icon)
      store_guess(guess)
      guess.join
    end
  end

  def end_turn(hint)
    @hints.push(hint)
    process_hint(@hints[-1])
  end
end
