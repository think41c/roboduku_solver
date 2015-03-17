require_relative './sudoku_solver'
require_relative './puzzle'

class Runner

  attr_accessor :good_solution

  attr_reader :original_puzzle

  def initialize(filename)
    @original_puzzle = Puzzle.new(filename).original_puzzle
    @good_solution = false
  end

  def find_solution
    solver = SudokuSolver.new(original_puzzle)
    solution = solver.solve_puzzle
  end

  def check_solution(solution)
    @good_solution = solution.none? {|value| value.to_i == 0}
  end

end

start_time = Time.now
counter = 0

while true
  run = Runner.new("puzzle_5.txt")
  solution = run.find_solution
  run.check_solution(solution)
  counter += 1
  break if run.good_solution == true
end

end_time = Time.now
time = end_time - start_time
print solution
puts "\n"
puts counter
puts time


