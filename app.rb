# frozen_string_literal: false

require 'pry-byebug'
require './peg'
require './row'

# Game stores game state, manages game loop
class Game
  PEGS = [Peg.new('B'), Peg.new('R'), Peg.new('O'), Peg.new('Y'), Peg.new('G'),
          Peg.new('P')].freeze

  attr_reader :guesses, :code

  def initialize
    @game_over = false
    @turn = 1
    @code = []
    4.times { @code.push(PEGS.sample) }
    @guesses = []
  end

  private

  def increment_turn
    if @turn == 12
      @game_over = true
    else
      @turn += 1
      puts "Turn #{@turn}"
    end
  end

  def game_over?
    @game_over
  end

  def structure_guess(guess)
    guess.split('')
  end

  def make_guess(guess)
    pegs = guess.map { |color| Peg.new(color) }
    @guesses.push(pegs)
  end

  def take_turn
    make_guess structure_guess gets.chomp
  end

  def guess_is_correct?
    puts @guesses[-1]
    correct_spots(@guesses[-1]).length == 4
  end

  def correct_colors(row)
    @code.filter { |peg| row.find { |guess| guess.color == peg.color } }
  end

  def correct_spots(row)
    @code.filter { |peg| row.find { |guess| guess.color == peg.color } }
  end

  def generate_hint(row)
    puts "#{correct_spots(row).length} pegs in the right place"
    puts "#{correct_colors(row).length - correct_spots(row).length} pegs are the right color, but in the wrong place."
    puts "#{4 - correct_colors(row).length} pegs are wrong altogether."
  end

  def end_turn
    @game_over = true if guess_is_correct?
    generate_hint(@guesses[-1])
    increment_turn
  end

  public

  def start_game
    until game_over?
      take_turn
      end_turn
    end
    if correct_spots(@guesses[-1]).length == 4
      puts 'You Won!'
    else
      puts 'You Lose!'
    end
  end
end

game = Game.new
game.start_game
