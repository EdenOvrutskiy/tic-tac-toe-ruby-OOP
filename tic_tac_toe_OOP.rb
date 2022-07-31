require 'pry'

#procedural, no sense changing
def print_welcome_messages
  puts "welcome to tic tac toe"
  puts "select a tile with the following syntax:"
  puts "{row_column}"
  puts "{top/middle/bottom}-{left/middle/right}"
  puts "for example: 'top_middle'"
end

##OOP:

board_data =
  [
    ['X', nil, nil],
    [nil, nil, nil],
    [nil, nil, nil]
  ]
#note: I don't have to use a data structure, could have just
#used 9 variables and name them accordingly, but this lets
#me practice encapsulating data structures

#implementing Struct class instead of creating a class.

Board = Struct.new(:top_left, :top_middle, :top_right,
                   :middle_left, :middle_middle, :middle_right,
                    :bottom_left, :bottom_middle, :bottom_right)
#turn array entries into input arguments
my_board = Board.new(*board_data.flatten)

p my_board.top_left
