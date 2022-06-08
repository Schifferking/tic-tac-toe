class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def fill_cell(board, row, column)    
    board.board[row][column] = mark
  end
end

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(3) {Array.new(3, nil)}
    @COORDINATES = {"top left" => [0, 0],
      "top center" => [0, 1],
      "top right" => [0, 2],
      "middle left" => [1, 0],
      "middle center" => [1, 1],
      "middle right" => [1, 2],
      "bottom left" => [2, 0],
      "bottom center" => [2, 1],
      "bottom right" => [2, 2]}
  end

  def is_cell_empty?(row, column)
    return board[row][column] == nil
  end
  
  def is_board_full?
    board.flatten.none?(nil)
  end

  def display_board
    puts ""
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

  def get_coordinates(direction)
    @COORDINATES.fetch(direction, "unknown")
  end
end

def game
  p1 = Player.new('X')
  p2 = Player.new('O')
  b = Board.new

  b.display_board
  puts "Where do you want to place your mark?"
  p_direction = gets.chomp.downcase
  p_coordinates = b.get_coordinates(p_direction)
  puts ""
  while p_coordinates == "unknown"
    puts "Please enter a valid direction"
    p_direction = gets.chomp.downcase
    p_coordinates = b.get_coordinates(p_direction)
    puts ""
  end

  p1.fill_cell(b, p_coordinates.first, p_coordinates.last)
  b.display_board
end

game
