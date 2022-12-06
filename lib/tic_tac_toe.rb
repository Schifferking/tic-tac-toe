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
