require 'pry'

###function definitions###
def print_welcome_messages
  puts "welcome to tic tac toe"
  puts "select a tile with the following syntax:"
  puts "{row-position}"
  puts "{top/middle/bottom}-{left/middle/right}"
  puts "for example: 'top_middle'"
end

 def print_board(board_hash)
  first_row = ''
  first_row << board_hash[:top_left]
  first_row << "|"
  first_row << board_hash[:top_middle] 
  first_row << "|"
  first_row << board_hash[:top_right]
  second_row = ''
  second_row <<  board_hash[:middle_left] 
  second_row << "|"
  second_row <<  board_hash[:middle_middle] 
  second_row << "|"
  second_row <<  board_hash[:middle_right]
  third_row = ''
  third_row << board_hash[:bottom_left]
  third_row << '|'
  third_row << board_hash[:bottom_middle]
  third_row << '|'
  third_row << board_hash[:bottom_right]

  for row in [first_row, second_row, third_row]
    puts row
  end
end

def valid_input?(input, board_hash)
    target_tile_value = board_hash["#{input}".to_sym]
    if board_hash.include?(input) == false
      puts "bad input! target-tile name mispelled"
      return false
    elsif (target_tile_value == 'X' || target_tile_value == 'O')
      puts "bad input! can't overwrite a previous move"
      return false
    else
      return true
    end
end
#determine whose turn it is
#based on the previous turn
def set_mark(mark)
  case mark
  when 'X' then 'O'
  when 'O' then 'X'
  else
    puts "error - bad mark"
  end
end

def is_game_over?(board_hash, recent_mark)
  #test win conditions
  #horizontal top row win con
  top_left = board_hash[:top_left]
  top_middle = board_hash[:top_middle]
  top_right = board_hash[:top_right]
  first_row = [top_left, top_middle, top_right]
  return first_row.all? {|mark| mark == recent_mark} 
end

####end of  of function definitons####

print_welcome_messages
#cause input to update board display
#create malliable board:
board_hash =
  {
    top_left: "_",top_middle: "_", top_right: "_",
    middle_left: "_", middle_middle: "_", middle_right: "_",
    bottom_left: " ", bottom_middle: " ", bottom_right: " ",
  }

#draw the board based on the initial hash info
print_board(board_hash)

#play a game
game_not_over = true
mark = 'X'  #initial mark
while game_not_over
  puts "#{mark}'s turn"
  input = gets.chomp.to_sym
  #check if input is correct
  while valid_input?(input, board_hash) == false
    input = gets.chomp.to_sym
  end
  #display the move
  #use the input to change the correct board_hash entry
  board_hash["#{input}".to_sym] = mark
  print_board(board_hash)
  #set up for next move 
  if is_game_over?(board_hash, mark)
    puts "game over"
    break
  end
  mark = set_mark(mark)
end
