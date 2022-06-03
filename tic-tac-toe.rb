class Player
  def initialize(mark)
    @mark = mark
  end
end

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(3, Array.new(3, nil))
  end

  def is_cell_empty?(row, column)
    return board[row][column] == nil
  end
  
  def is_board_full?
    board.flatten.none?(nil)
  end
end
