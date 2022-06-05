class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def fill_cell(row, column, board)    
    board.board[row][column] = mark
  end
end

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(3) {Array.new(3, nil)}
  end

  def is_cell_empty?(row, column)
    return board[row][column] == nil
  end
  
  def is_board_full?
    board.flatten.none?(nil)
  end

  def display_board
    board.each_with_index do |row, row_index|
      print " "
      row.each_with_index do |column, column_index|
        if is_cell_empty?(row_index, column_index)
          print "  "
        else
          print board[row_index][column_index] + " "
        end
        print "| " if column_index <= 1
      end
      print "\n"
      print " ---------\n" if row_index <= 1
    end
    puts ""
  end
end
