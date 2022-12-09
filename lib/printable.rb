module Printable
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
