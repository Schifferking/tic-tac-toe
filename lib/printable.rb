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
end
