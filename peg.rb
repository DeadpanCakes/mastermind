# frozen_string_literal: false

# Peg stores color
class Peg
  attr_reader :color, :icon

  def initialize(icon)
    @color = determine_color(icon)
    @icon = icon
  end

  private

  def color_map
    { 'B' => 'Blue',
      'R' => 'Red',
      'G' => 'Green',
      'O' => 'Orange',
      'Y' => 'Yellow',
      'P' => 'Purple' }
  end

  def determine_color(icon)
    color_map[icon]
  end
end
