require_relative './board'
require_relative './puzzle'

class SudokuSolver

  attr_accessor :guess_puzzle

  attr_reader :square_reference,
              :origin,
              :board

  def initialize(original_puzzle)
    @origin = original_puzzle
    @guess_puzzle = original_puzzle
    @board = Board.new
    @square_reference = { 0 => 0,  1 => 3,  2 => 6, 
                          3 => 27, 4 => 30, 5 => 33,
                          6 => 54, 7 => 57, 8 => 60} 
  end

  def solve_puzzle
    guess_puzzle = origin
    guess_puzzle.each_with_index do |value, index|
      if value.to_i == 0
        number = guess_a_number(index)
        guess_puzzle[index] = number
      else
        guess_puzzle[index] = value.to_i
      end
    end
  end

  def guess_a_number(index)
    row_values = check_your_row(index)
    column_values = check_your_column(index)
    square_values = check_your_square(index)
    used_values = (row_values + column_values + square_values).uniq
    random_digit_spitter(used_values)
  end

  def random_digit_spitter(used_values)
    guess = (0..9).reject { |check_num| used_values.any? { |value| value == check_num } }
    if guess == []
      return 0
    else
      guess.sample
    end
  end

  def check_your_row(index)
    row_number = board.what_row_am_i_in(index)
    row = find_row(row_number)
  end

  def check_your_column(index)
    column_number = board.what_column_am_i_in(index)
    column = find_column(column_number)
  end

  def check_your_square(index)
    square_number = board.what_square_am_i_in(index)
    square = find_square(square_number)
  end

  def find_row(row_number)
    start = row_number * 9
    (start..start+8).map { |index| guess_puzzle[index].to_i }
  end

  def find_column(column_number)
    (0..8).map { |index| guess_puzzle[column_number + index*9].to_i }    
  end

  def find_square(square_index)
    square_start = @square_reference[square_index].to_i
    square = []
    (0..2).map do |line|
      (0..2).map do |index|
        square << guess_puzzle[square_start + (index+line*9)].to_i
      end
    end
    square
  end

  def check_solution(solution)
    solution.none? {|value| value.to_i == 0}
  end

end