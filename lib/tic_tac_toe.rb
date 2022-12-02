require_relative '../lib/player'

class Board
  attr_accessor :board, :lines

  def initialize
    create_board
    @COORDINATES = directions_hash
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

  def display_board
    print_empty_line
    board.each_with_index do |row, row_index|
      print_empty_space
      print_row(row, row_index)
      print_empty_line
      print_horizontal_line if row_index <= 1
    end
    print_empty_line
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
               'right column' => [board[0][2], board[1][2], board[2][2]],
               'left diagonal' => [board[0][0], board[1][1], board[2][2]],
               'right diagonal' => [board[0][2], board[1][1], board[2][0]] }
  end

  def line_filled?
    update_lines

    lines.each do |key, _value|
      return true if lines[key].all?('X') || lines[key].all?('O')
    end

    false
  end

  private

  def create_board
    @board = Array.new(3) { Array.new(3, nil) }
  end

  def directions_hash
    { 'top left' => [0, 0],
      'top center' => [0, 1],
      'top right' => [0, 2],
      'middle left' => [1, 0],
      'middle center' => [1, 1],
      'middle right' => [1, 2],
      'bottom left' => [2, 0],
      'bottom center' => [2, 1],
      'bottom right' => [2, 2] }
  end

  def print_square_content(row, column)
    if !cell_filled?(row, column)
      print_empty_space
      print_empty_space
    else
      print "#{board[row][column]} "
    end
  end

  def print_row(row, row_index)
    row.each_with_index do |_, column_index|
      print_square_content(row_index, column_index)
      print '| ' if column_index <= 1
    end
  end

  def print_empty_line
    puts ''
  end

  def print_horizontal_line
    print ' ---------'
    print_empty_line
  end

  def print_empty_space
    print ' '
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
    p_direction = player.enter_coordinates
    p_coordinates = b.get_coordinates(p_direction)
    puts ''

    # Validate player's input
    while p_coordinates == 'unknown' || b.cell_filled?(p_coordinates.first, p_coordinates.last)
      puts 'Please enter a valid direction'
      p_direction = player.enter_coordinates
      p_coordinates = b.get_coordinates(p_direction)
      puts ''
      if p_coordinates != 'unknown'
        break unless b.cell_filled?(p_coordinates.first, p_coordinates.last)
      end
    end

    player.fill_cell(b, p_coordinates.first, p_coordinates.last)

    # Winner
    if b.line_filled?
      b.display_board

      puts "#{player} won!"
      break
    end
  end

  # Tie
  unless b.line_filled?
    b.display_board

    puts "It's a tie!"
  end
end
