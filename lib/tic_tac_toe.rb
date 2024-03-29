require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/printable'

class TicTacToe
  include Printable
  attr_reader :player_x, :player_o

  def initialize
    @player_x = Player.new('X')
    @player_o = Player.new('O')
    @board = Board.new
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

  def obtain_left_diagonal
    @board.obtain_left_diagonal
  end

  def obtain_right_diagonal
    @board.obtain_right_diagonal
  end

  def print_board
    @board.print_board
  end

  def diagonal_coordinates(direction)
    direction == 'left' ? left_diagonal_coordinates : right_diagonal_coordinates
  end

  def diagonal_values(direction)
    direction == 'left' ? obtain_left_diagonal : obtain_right_diagonal
  end

  def check_diagonal(row, column, player_mark, direction)
    diagonal = diagonal_coordinates(direction)
    return unless coordinates_in_line?(row, column, diagonal)

    diagonal_line = diagonal_values(direction)
    return true if line_filled?(diagonal_line, player_mark)
  end

  def winner?(row, column, player_mark)
    row_line = obtain_row(row)
    return true if line_filled?(row_line, player_mark)

    column_line = obtain_column(column)
    return true if line_filled?(column_line, player_mark)

    return true if check_diagonal(row, column, player_mark, 'left')

    return true if check_diagonal(row, column, player_mark, 'right')

    false
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
  end

  def left_diagonal_coordinates
    [[0, 0], [1, 1], [2, 2]]
  end

  def right_diagonal_coordinates
    [[0, 2], [1, 1], [2, 0]]
  end

  def coordinates_in_line?(row, column, diagonal)
    coordinates = [row, column]
    diagonal.include?(coordinates)
  end

  def obtain_current_player(player)
    player == player_x ? player_o : player_x
  end

  def game(current_player = player_x)
    print_welcome_message

    loop do
      print_current_player_turn(current_player.mark)
      row, column = obtain_valid_coordinates(current_player)
      fill_cell(row, column, current_player.mark)
      print_board
      return print_winner_message(current_player.mark) if winner?(row, column, current_player.mark)
      return print_tie_message if tie?

      current_player = obtain_current_player(current_player)
    end
  end
end
