require 'pry'

###Function definitions###
#########################
def print_welcome_messages
  puts "welcome to tic tac toe"
  puts "select a tile with the following syntax:"
  puts "{row_column}"
  puts "{top/middle/bottom}-{left/middle/right}"
  puts "for example: 'top_middle'"
end

#encapsulate (hide) data ('s structure) by turning it into behavior
def get_top_left(board_hash)
  return board_hash[:top_left]
end

def get_top_right(board_hash)
  return board_hash[:top_right]
end

def get_top_middle(board_hash)
  return board_hash[:top_middle]
end

def get_middle_left(board_hash)
  return board_hash[:middle_left]
end

def get_middle_right(board_hash)
  return board_hash[:middle_right]
end

def get_middle_middle(board_hash)
  return board_hash[:middle_middle]
end

def get_bottom_left(board_hash)
  return board_hash[:bottom_left]
end

def get_bottom_right(board_hash)
  return board_hash[:bottom_right]
end

def get_bottom_middle(board_hash)
  return board_hash[:bottom_middle]
end

#change target tile of board
def set_bottom_middle(input, board_hash)
  board_hash[:bottom_middle] = input
end

#display board
def print_board(board_data)
  #expects strings or nils as data in board's cells
  
  #get all cell values from board data
  top_left = get_top_left(board_data)
  top_middle = get_top_middle(board_data)
  top_right = get_top_right(board_data)
  middle_left =  get_middle_left(board_data)
  middle_middle =  get_middle_middle(board_data)
  middle_right =  get_middle_right(board_data)
  bottom_left =  get_bottom_left(board_data)
  bottom_middle =  get_bottom_middle(board_data)
  bottom_right =  get_bottom_right(board_data)

  #process them:
  #replace `nil` values in the top 2 rows with '_'
  top_left = top_left.nil? ? '_' : top_left
  top_middle = top_middle.nil? ? '_' : top_middle
  top_right = top_right.nil? ? '_' : top_right
  middle_left =  middle_left.nil? ? '_' : middle_left
  middle_middle =  middle_middle.nil? ? '_' : middle_middle
  middle_right =  middle_right.nil? ? '_' : middle_right

  #replace `nil` values in the last row with ' '
  bottom_left =  bottom_left.nil? ? ' ' : bottom_left
  bottom_middle =  bottom_middle.nil? ? ' ' : bottom_middle
  bottom_right =  bottom_right.nil? ? ' ' : bottom_right

  first_row = '' << top_left << '|' << top_middle << '|' <<
              top_right
  second_row = '' << middle_left << '|' << middle_middle << '|' <<
               middle_right
  third_row = '' << bottom_left << '|' << bottom_middle << '|' <<
              bottom_right

  #print out each row
  [first_row, second_row, third_row].each {|row| puts row}
end

def tile_value(input, board_hash) # breaks when nil
  #returns value of cell that's indicated by input's target
  # or false / nil if not found
    
  #convert input to symbol
  if input.is_a? String
    input = input.chomp.to_sym
  elsif input.nil? == false
    input = input.to_sym
  else
    return false
  end

  #attempt to use a symbol to access a value in the hash
  case input
  when :top_right then get_top_right(board_hash)
  when :top_middle then get_top_middle(board_hash)
  when :top_left then get_top_left(board_hash)
  when :middle_right then get_middle_right(board_hash)
  when :middle_middle then get_middle_middle(board_hash)
  when :middle_left then get_middle_left(board_hash)
  when :bottom_right then get_bottom_right(board_hash)
  when :bottom_middle then get_bottom_middle(board_hash)
  when :bottom_left then get_bottom_left(board_hash)
  #if symbol isn't valid, returns false
  else
    false
  end
end

def valid_input?(input, board_hash)
  #tests player-input 
  target_tile_value = tile_value(input, board_hash)
  #target_tile_value = board_hash["#{input}".to_sym]
  if target_tile_value == false
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
  top_left = get_top_left(board_hash)
  top_middle = get_bottom_middle(board_hash)
  top_right = get_top_right(board_hash)
  middle_left =  get_middle_left(board_hash)
  middle_middle =  get_middle_middle(board_hash)
  middle_right =  get_middle_right(board_hash)
  bottom_left =  get_bottom_left(board_hash)
  bottom_middle =  get_bottom_middle(board_hash)
  bottom_right =  get_bottom_right(board_hash)
  top_left = get_top_left(board_hash)
  #test win conditions

  #horizontal rows
  top_row = [top_left, top_middle, top_right]
  middle_row = [middle_left, middle_middle, middle_right]
  bottom_row = [bottom_left, bottom_middle, bottom_right]

  #vertical columns
  left_column = [top_left, middle_left, bottom_left]
  middle_column = [top_middle, middle_middle, bottom_middle]
  right_column = [top_right, middle_right, bottom_right]
  
  #diagonals
  backslash = [bottom_left, middle_middle, top_right]
  forward_slash = [bottom_right, middle_middle, top_left]

  #gather all the tile_sets required for checking win conditions
  tile_sets = [
    top_row, middle_row, bottom_row,
    left_column, middle_column, right_column,
    backslash, forward_slash
  ]
  #see if any of them
  game_over =
    tile_sets.any? do |set|
    #are filled with the same mark
    set.all? {|mark| mark == recent_mark}
  end
  #if so, the game is over
  return game_over
end

def play_a_game(board_hash)
  game_not_over = true
  mark = 'X'  #initial mark
  while game_not_over
    puts "#{mark}'s turn"
    input = gets
    #check if input is correct
    while valid_input?(input, board_hash) == false
      #if input is bad, ask again
      input = gets
    end
    #use the input to change the correct board_hash entry to
    board_hash["#{input}".chomp.to_sym] = mark
    #display the move
    print_board(board_hash)
    #check if the move was game-winning
    if is_game_over?(board_hash, mark)
      puts "game over"
      break
    end
    #if not, give turn to next player
    mark = set_mark(mark)
  end
end

def return_clear_board
  board_hash =
    {
      top_left: "_",top_middle: "_", top_right: "_",
      middle_left: "_", middle_middle: "_", middle_right: "_",
      bottom_left: " ", bottom_middle: " ", bottom_right: " ",
    }
end

def play_a_kind_of_game(moves = false)
  #this function exists to reduce duplication in
  #play_a_game and play_an_automatic_game

  #expects a 1D array of strings representing inputs
  board_hash = return_clear_board
  game_not_over = true
  mark = 'X'  #initial mark
  while game_not_over
    puts "#{mark}'s turn"
    input = moves ? moves.shift : gets
    while valid_input?(input, board_hash) == false
      unless moves.empty?
        input = moves ? moves.shift : gets
      else
        puts "no valid moves remain in this automated game"
        break
      end
    end
    if input.nil? then
      #if the last input was bad, and there are no more moves
      #in the automated game, break
      break
    else
      #use the input to change the correct board_hash entry to
      board_hash[input.to_sym] = mark
      #display the move
      print_board(board_hash)
      #if the move wasn't game winning, pass the turn
      is_game_over?(board_hash, mark) ? break : mark = set_mark(
        mark)
    end
  end
  puts "game over"
end

def play_an_automatic_game(moves)
  board_hash = return_clear_board
  #automate inputs
  mark = 'X'  #initial mark
  for move in moves do
    sleep 0.05
    puts "#{mark}'s turn"
    input = move
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
  bad_game = [
    'bottom_left', 'bottom_left', #trying to overwrite move
    'bottom_right', 'bottom_right'
  ]
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
  bottom_row_win_x = [
    'bottom_left', 'middle_left',
    'bottom_middle', 'middle_middle',
    'bottom_right', 'middle_right'
  ]
  left_column_win_o = [
    'bottom_right', 'top_left',
    'top_right', 'bottom_left',
    'middle_middle', 'middle_left'
  ]
  middle_column_win_x = [
    'middle_middle', 'top_right', 
    'bottom_middle', 'bottom_left',
    'top_middle', 'top_left'
  ]
  right_column_win_o = [
    'top_left', 'top_right',
    'middle_middle', 'middle_right',
    'middle_left', 'bottom_right',
  ]
  forward_slash_win_x = [
    'bottom_left', 'middle_right',
    'middle_middle', 'middle_left',
    'top_right', 'top_left'
  ]
  backslash_win_o = [
    'middle_left' , 'bottom_right',
    'middle_right', 'middle_middle',
    'top_middle', 'top_left',
  ]
  games = [
    bad_game,
    top_row_win_x, middle_row_win_o, bottom_row_win_x,
    left_column_win_o, middle_column_win_x, right_column_win_o,
    forward_slash_win_x, backslash_win_o
  ]
  for game in games
    play_a_kind_of_game(game)
    #play_an_automatic_game(game)
  end
end
######################################
####end of  of function definitons####

#executable code:
print_welcome_messages
#cause input to update board display
#create malliable board:
board_2d_array = [
  [nil, nil, nil],
  [nil, nil, nil],
  [nil, nil, nil]
]

board_hash =
  {
    top_left: nil ,top_middle: nil, top_right: nil,
    middle_left: nil, middle_middle: nil, middle_right: nil,
    bottom_left: nil, bottom_middle: nil, bottom_right: nil,
  }

backslash_win_o = [
  'middle_left' , 'bottom_right',
  'middle_right', 'middle_middle',
  'top_middle', 'top_left',
]

#draw the board based on the initial hash info
#print_board(board_hash)

#play_a_game(board_hash)
#play_an_automatic_game(backslash_win_o) # works
test_program

bad_game = [
  'bottom_left', 'bottom_left', #trying to overwrite move
  'bottom_right', 'bottom_right'
]
#play_a_kind_of_game(bad_game)
