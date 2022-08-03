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
  # private
  # attr_writer :top_left, :top_middle, :top_right,
  #             :middle_left, :middle_middle, :middle_right,
  #             :bottom_left, :bottom_middle, :bottom_right
  public
  attr_reader :top_left, :top_middle, :top_right,
              :middle_left, :middle_middle, :middle_right,
              :bottom_left, :bottom_middle, :bottom_right

  def initialize
    #a board is made up of 9 cells
    @top_left = Cell.new()
    @top_left.set_row_top
    @top_left.set_column_left

    @top_middle = Cell.new()
    @top_middle.set_row_top
    @top_middle.set_column_middle

    @top_right = Cell.new()
    @top_right.set_row_top
    @top_right.set_column_right

    @middle_left = Cell.new()
    @middle_left.set_row_middle
    @middle_left.set_column_left

    @middle_middle = Cell.new()
    @middle_middle.set_row_middle
    @middle_middle.set_column_middle

    @middle_right = Cell.new()
    @middle_right.set_row_middle
    @middle_right.set_column_right

    @bottom_left = Cell.new()
    @bottom_left.set_row_bottom
    @bottom_left.set_column_left

    @bottom_middle = Cell.new()
    @bottom_middle.set_row_bottom
    @bottom_middle.set_column_middle

    @bottom_right = Cell.new()
    @bottom_right.set_row_bottom
    @bottom_right.set_column_right
  end

  def display
    top_row = ''
    top_row << top_left.printable
    top_row << '|'
    top_row << top_middle.printable
    top_row << '|'
    top_row << top_right.printable

    middle_row = ''
    middle_row << middle_left.printable
    middle_row << '|'
    middle_row << middle_middle.printable
    middle_row << '|'
    middle_row << middle_right.printable

    bottom_row = ''
    bottom_row << bottom_left.printable
    bottom_row << '|'
    bottom_row << bottom_middle.printable
    bottom_row << '|'
    bottom_row << bottom_right.printable

    puts top_row
    puts middle_row
    puts bottom_row
  end
end

class Cell
  private
  attr_writer :content, :row, :column

  public
  attr_reader :content, :row, :column

  def initialize
    @row = nil
    @column = nil
    @content = nil
  end

  #set row as top, middle or bottom
  def set_row_top
    self.row = 'top'
  end

  def set_row_middle
    self.row = 'middle'
  end

  def set_row_bottom
    self.row = 'bottom'
  end

  #set column as left, middle or right
  def set_column_left
    self.column = 'left'
  end

  def set_column_middle
    self.column = 'middle'
  end

  def set_column_right
    self.column = 'right'
  end

  def overwrite_error
    puts "error: attempted to overwrite cell #{self}"
  end

  def mark_x
    if self.content == nil then self.content = 'X'
    else
      overwrite_error
    end
  end

  def mark_o
    if self.content == nil then self.content = 'O'
    else
      overwrite_error
    end
  end

  def printable
    if self.content.nil?
      self.row == 'bottom' ? ' ' : '_'
    else
      self.content
    end
  end
end

# celly = Cell.new()
# celly.mark_X
# p celly.set_row_top
# p celly.row
# p celly.column
# p celly.set_column_right
# p celly.column

# puts ###
# p celly

#Board.new().
#celly = Cell.new()
#celly.mark_x
#celly.set_row_middle

#boardy = Board.new()
#boardy.display

# boardy = Board.new()
# boardy.top_left.mark_o
# boardy.display

celly = Cell.new()
p celly.mark_x
p celly.mark_o
p celly
