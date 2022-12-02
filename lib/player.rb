class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def fill_cell(board, row, column)
    board.fill_cell(row, column, mark)
  end

  def to_s
    @mark
  end

  def enter_coordinates
    gets.chomp.downcase
  end
end
