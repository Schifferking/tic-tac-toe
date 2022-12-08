require_relative '../lib/player'
require_relative '../lib/board'

class TicTacToe
  attr_reader :player_x, :player_o

  def initialize
    @player_x = Player.new('X')
    @player_o = Player.new('O')
    @board = Board.new
  end

  def print_welcome_message
    puts 'Welcome to a new Tic tac toe game!'
  end

  def print_current_player_turn(player)
    puts "#{player}'s turn"
  end

  def print_prompt_message
    puts 'Please select a number between 1 and 9 to place a mark'
    puts '1 means the top left cell and 9 means the bottom right cell'
  end

  def print_tie_message
    puts "It's a tie!"
  end

  def print_winner_message(player_mark)
    puts "#{player_mark}'s player wins!"
  end

  def number?(input)
    input == input.to_i.to_s
  end

  def number_in_range?(number)
    number if number.between?(1, 9)
  end

  def obtain_cell_value(row, column)
    @board.obtain_cell_value(row, column)
  end

  def fill_cell(row, column, mark)
    @board.fill_cell(row, column, mark)
  end

  def cell_filled?(row, column)
    @board.cell_filled?(row, column)
  end

  def tie?
    @board.board_full?
  end

  def obtain_row(row)
    @board.obtain_row_values(row)
  end

  def obtain_column(column)
    @board.obtain_column_values(column)
  end

  def line_filled?(line, player_mark)
    @board.line_filled?(line, player_mark)
  end

  def coordinates_hash
    { 1 => [0, 0],
      2 => [0, 1],
      3 => [0, 2],
      4 => [1, 0],
      5 => [1, 1],
      6 => [1, 2],
      7 => [2, 0],
      8 => [2, 1],
      9 => [2, 2] }
  end

  def obtain_cell_coordinates(number)
    coordinates_hash[number]
  end

  def validate_number(input)
    return false unless number?(input)

    input_number = input.to_i
    return false unless number_in_range?(input_number)

    row, column = obtain_cell_coordinates(input_number)
    !cell_filled?(row, column)
  end

  def obtain_current_player_input(current_player)
    current_player.enter_input
  end

  def obtain_valid_coordinates(current_player)
    loop do
      print_prompt_message
      input = obtain_current_player_input(current_player)
      return obtain_cell_coordinates(input.to_i) if validate_number(input)
    end
  
    
    def left_diagonal_coordinates
      [[0, 0], [1, 1], [2, 2]]
    end

    def right_diagonal_coordinates
      [[0, 2], [1, 1], [2, 0]]
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
