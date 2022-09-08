# frozen_string_literal: false

# Peg stores color
class Peg
  attr_reader :color

  def initialize(color)
    @color = color
    @icon = color[0].upcase
  end
end
