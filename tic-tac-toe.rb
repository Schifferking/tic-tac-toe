class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def fill_cell(board, row, column)
    board.board[row][column] = mark
  end

  def to_s
    @mark
  end
end

class Board
  attr_accessor :board, :lines

  def initialize
    @board = Array.new(3) { Array.new(3, nil) }
    @COORDINATES = { 'top left' => [0, 0],
                     'top center' => [0, 1],
                     'top right' => [0, 2],
                     'middle left' => [1, 0],
                     'middle center' => [1, 1],
                     'middle right' => [1, 2],
                     'bottom left' => [2, 0],
                     'bottom center' => [2, 1],
                     'bottom right' => [2, 2] }
  end

  def is_cell_filled?(row, column)
    return board[row][column] != nil
  end

  def is_board_full?
    board.flatten.none?(nil)
  end

  def display_board
    puts ''
    board.each_with_index do |row, row_index|
      print ' '
      row.each_with_index do |column, column_index|
        if !is_cell_filled?(row_index, column_index)
          print '  '
        else
          print board[row_index][column_index] + ' '
        end
        print '| ' if column_index <= 1
      end
      print "\n"
      print " ---------\n" if row_index <= 1
    end
    puts ''
  end

  def get_coordinates(direction)
    @COORDINATES.fetch(direction, 'unknown')
  end

  def update_lines
    @lines = { 'top row' => board[0],
               'middle row' => board[1],
               'bottom row' => board[2],
               'left column' => [board[0][0], board[1][0], board[2][0]],
               'middle column' => [board[0][1], board[1][1], board[2][1]],
               'right column' => [board[0][2], board[1][1], board[2][2]],
               'left diagonal' => [board[0][0], board[1][1], board[2][2]],
               'right diagonal' => [board[0][2], board[1][1], board[2][0]], }
  end

  def is_line_filled?
    update_lines

    lines.each do |key, value|
      if lines[key].all?('X')
        return true
      elsif lines[key].all?('O')
        return true
      end
    end

    false
  end
end

def game
  p1 = Player.new('X')
  p2 = Player.new('O')
  b = Board.new

  [p1, p2].cycle.first(9).each do |player|
    # Start of round
    puts "#{player}'s turn"

    b.display_board
    puts 'Where do you want to place your mark?'
    p_direction = gets.chomp.downcase
    p_coordinates = b.get_coordinates(p_direction)
    puts ''

    # Validate player's input
    while p_coordinates == 'unknown' || b.is_cell_filled?(p_coordinates.first, p_coordinates.last)
      puts 'Please enter a valid direction'
      p_direction = gets.chomp.downcase
      p_coordinates = b.get_coordinates(p_direction)
      puts ''
      if p_coordinates != 'unknown'
        unless b.is_cell_filled?(p_coordinates.first, p_coordinates.last)
          break
        end
      end
    end

    player.fill_cell(b, p_coordinates.first, p_coordinates.last)

    # Winner
    if b.is_line_filled?
      b.display_board

      puts "#{player} won!"
      break
    end
  end

  # Tie
  unless b.is_line_filled?
    b.display_board

    puts "It's a tie!"
  end
end

game
