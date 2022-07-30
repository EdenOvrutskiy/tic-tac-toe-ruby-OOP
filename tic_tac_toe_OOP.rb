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
class Board
  private
  attr_reader :top_left
  attr_reader :top_middle
  attr_reader :top_right
  attr_reader :middle_left
  attr_reader :middle_middle
  attr_reader :middle_right
  attr_reader :bottom_left
  attr_reader :bottom_middle
  attr_reader :bottom_right

  public
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
  def display
    p [top_left, top_middle, top_right]
    p [middle_left, middle_middle, middle_right]
    p [bottom_left, bottom_middle, bottom_right]
  end
end

first_board = Board.new()
first_board.display
