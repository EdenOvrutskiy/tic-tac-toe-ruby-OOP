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
  #list all cells
  top_left = board_hash[:top_left]
  top_middle = board_hash[:top_middle]
  top_right = board_hash[:top_right]
  middle_left = board_hash[:middle_left]
  middle_middle = board_hash[:middle_middle]
  middle_right = board_hash[:middle_right]
  #test win conditions
  #horizontal top row win con
  first_row = [top_left, top_middle, top_right]
  first_row_win_con = first_row.all? {|mark| mark == recent_mark} 
  #middle row win con
  middle_row = [middle_left, middle_middle, middle_right]
  middle_row_win_con = middle_row.all? {|mark| mark == recent_mark}
  return (middle_row_win_con ||
              first_row_win_con)
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

def play_a_game(board_hash)
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
end

def play_an_automatic_game(moves)
  #reset board
  board_hash =
    {
      top_left: "_",top_middle: "_", top_right: "_",
      middle_left: "_", middle_middle: "_", middle_right: "_",
      bottom_left: " ", bottom_middle: " ", bottom_right: " ",
    }
  #automate inputs
  game_not_over = true
  mark = 'X'  #initial mark
  for move in moves do
    sleep 0.5
    puts "#{mark}'s turn"
    input = move.to_sym
    #check if input is correct
    unless valid_input?(input, board_hash)
      next
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
end

def test_program
  top_row_win_x = [
    "top_right", "bottom_right",
    "top_middle", "bottom_middle",
    "top_left", "bottom_left"
  ]
  middle_row_win_o = [
    'bottom_left', 'middle_left',
    'top_left', 'middle_middle',
    'bottom_right', 'middle_right'
  ]
  games = [top_row_win_x, middle_row_win_o]
  for game in games
    play_an_automatic_game(game)
  end
end

test_program
#play_a_game(board_hash)
