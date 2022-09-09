# frozen_string_literal: false

require 'pry-byebug'
require './peg'
require './row'
require './ai'

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

  def structure_row(guess)
    guess.split('')
  end

  def make_guess(guess)
    pegs = guess.map { |color| Peg.new(color) }
    @guesses.push(pegs)
  end

  def take_turn(row)
    make_guess structure_row row
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
    { spot: correct_spots(row).length,
      color: correct_colors(row).length - correct_spots(row).length,
      wrong: 4 - correct_colors(row).length }
  end

  def end_turn
    @game_over = true if guess_is_correct?
    hint = generate_hint(@guesses[-1])
    puts "#{hint[:spot]} pegs in the right place"
    puts "#{hint[:color]} pegs are the right color, but in the wrong place."
    puts "#{hint[:wrong]} pegs are wrong altogether."
    increment_turn
  end

  public

  def start_game
    until game_over?
      take_turn gets.chomp
      end_turn
    end
    if correct_spots(@guesses[-1]).length == 4
      puts 'You Won!'
    else
      puts 'You Lose!'
    end
  end

  def start_mastermind
    ai = AI.new
    input = gets.chomp
    @code = structure_row(input).map { |icon| Peg.new(icon) }
    until game_over?
      take_turn(ai.take_turn(@turn))
      ai.end_turn(generate_hint(guesses[-1]))
      end_turn
    end
  end
end

game = Game.new
game.start_mastermind
