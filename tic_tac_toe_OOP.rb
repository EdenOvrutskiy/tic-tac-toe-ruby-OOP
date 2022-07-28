require 'pry'

#procedural, no sense changing
def print_welcome_messages
  puts "welcome to tic tac toe"
  puts "select a tile with the following syntax:"
  puts "{row_column}"
  puts "{top/middle/bottom}-{left/middle/right}"
  puts "for example: 'top_middle'"
end

#OOP
class Board
  @@empty_board =
    {
      top_left: "_",top_middle: "_", top_right: "_",
      middle_left: "_", middle_middle: "_", middle_right: "_",
      bottom_left: " ", bottom_middle: " ", bottom_right: " ",
    }
  def initialize
    @board_data = @@empty_board
  end
  def display
    top_left = @board_data[:top_left]
    top_middle = @board_data[:top_middle]
    top_right = @board_data[:top_right]
    middle_left =  @board_data[:middle_left] 
    middle_middle =  @board_data[:middle_middle] 
    middle_right = @board_data[:middle_right]
    bottom_left = @board_data[:bottom_left]
    bottom_middle = @board_data[:bottom_middle]
    bottom_right = @board_data[:bottom_right]

    first_row = '' << top_left << '|' << top_middle << '|' << top_right
    second_row = '' << middle_left << '|' << middle_middle << '|' <<
                 middle_right
    third_row = '' << bottom_left << '|' << bottom_middle << '|' << bottom_right

    #display board
    [first_row, second_row, third_row].each {|row| puts row}
  end
  def mark(location)
    @board_data[location] = 'X'
  end
end

print_welcome_messages
board = Board.new()
board.display
location = :top_left
board.mark(location)
board.display
