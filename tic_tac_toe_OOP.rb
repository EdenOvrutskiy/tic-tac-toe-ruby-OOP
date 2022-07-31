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
##I want an interface to the board data:
#instead of my program writing board_hash{:top_left}
#it should do board.top_left

board_data =
  [
    ['X', nil, nil],
    [nil, nil, nil],
    [nil, nil, nil]
  ]
#note: I don't have to use a data structure, could have just
#used 9 variables and name them accordingly, but this lets
#me practice encapsulating data structures

class Board
  #enables API access to board_data
  #before: board_data[0][1]
  #after: board_data.top_middle
  attr_accessor :top_left, :top_middle, :top_right,
                :middle_left, :middle_middle, :middle_right,
                :bottom_left, :bottom_middle, :bottom_right
  
  def initialize(board_data)
    @top_left      = board_data[0][0]
    @top_middle    = board_data[0][1]
    @top_right     = board_data[0][2]
    @middle_left   = board_data[1][0]
    @middle_middle = board_data[1][1]
    @middle_right  = board_data[1][2]
    @bottom_left   = board_data[2][0]
    @bottom_middle = board_data[2][1]
    @bottom_right  = board_data[2][2]
  end
end


###########
##old attempts to create objects / classes, keeping it below
##to later reference
class Board_old
  attr_reader :top_left, :top_middle, :top_right
  attr_reader :middle_left, :middle_middle, :middle_right
  attr_reader :bottom_left, :bottom_middle, :bottom_right

  def initialize
    @top_left = nil
    @top_middle = nil
    @top_right = nil
    @middle_left = nil
    @middle_middle = nil
    @middle_right = nil
    @bottom_left = nil
    @bottom_middle = nil
    @bottom_right = nil
  end
end

class Board_displayer
  attr_reader :board
  
  def initialize(board)
    @board = board
  end
  
  def display
    puts board.top_left
  end
end

class User_input_reader
  def initialize
    @input = gets
  end
end
######################


p Board.new(board_data).top_left
