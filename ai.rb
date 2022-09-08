# frozen_string_literal: false

require './peg'

# AI to make informed guesses
class AI
  OPTIONS = [Peg.new('B'), Peg.new('P'), Peg.new('O'), Peg.new('Y'), Peg.new('G'), Peg.new('R')].freeze

  def initialize
    @eliminated = [[], [], [], []]
  end

  def pick_peg(eliminated)
    OPTIONS.reject { |option| eliminated.include?(option) }.sample
  end
end
