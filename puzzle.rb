class Puzzle

  attr_reader :original_puzzle

  def initialize(filename)
    split_puzzle(read_puzzle(filename))
  end

  def read_puzzle(filename)
    sudoku_puzzle = []
    File.open("./puzzles/#{filename}").readlines.each do |line|
      sudoku_puzzle << line
    end 
  end

  def split_puzzle(sudoku_puzzle)
    @original_puzzle = sudoku_puzzle.join('').delete("\n").split('')
  end

end