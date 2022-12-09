require_relative '../lib/printable'

class Board
  include Printable
  attr_reader :board

  def initialize
    create_board
  end

  def fill_cell(row, column, mark)
    board[row][column] = mark
  end

  def cell_filled?(row, column)
    !board[row][column].nil?
  end

  def board_full?
    @board.flatten.none?(nil)
  end

  def print_board
    print_empty_line
    board.each_with_index do |row, row_index|
      print_empty_space
      print_row(row, row_index)
      print_empty_line
      print_horizontal_line if row_index <= 1
    end
    print_empty_line
  end

  def obtain_row_values(row)
    board[row]
  end

  def obtain_cell_value(row, column)
    board[row][column]
  end

  def obtain_column_values(column)
    [obtain_cell_value(0, column),
     obtain_cell_value(1, column),
     obtain_cell_value(2, column)]
  end

  def obtain_left_diagonal
    [obtain_cell_value(0, 0),
     obtain_cell_value(1, 1),
     obtain_cell_value(2, 2)]
  end

  def obtain_right_diagonal
    [obtain_cell_value(0, 2),
     obtain_cell_value(1, 1),
     obtain_cell_value(2, 0)]
  end

  def line_filled?(line, mark)
    line.all? { |cell| cell == mark }
  end

  private

  def create_board
    @board = Array.new(3) { Array.new(3, nil) }
  end

  def print_square_content(row, column)
    if !cell_filled?(row, column)
      print_empty_space
    else
      print board[row][column].to_s
    end
    print_empty_space
  end

  def print_row(row, row_index)
    row.each_with_index do |_, column_index|
      print_square_content(row_index, column_index)
      print '| ' if column_index <= 1
    end
  end
end
