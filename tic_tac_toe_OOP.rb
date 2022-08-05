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
  attr_accessor :previous_mark
  
  public
  attr_reader :top_left, :top_middle, :top_right,
              :middle_left, :middle_middle, :middle_right,
              :bottom_left, :bottom_middle, :bottom_right,
              :table,
              :top_left_struct, :top_middle_struct,
              :top_right_struct,
              :middle_left_struct,
              :middle_middle_struct, :middle_right_struct,
              :bottom_left_struct, :bottom_middle_struct,
              :bottom_right_struct

  Table_cell = Struct.new(:cell, :row, :column)
  def initialize(cell)
    #3x3 board
    rows = [:top, :middle, :bottom]
    columns = [:left, :middle, :right]
    @table = []
    for row in rows
      for column in columns
        table_cell = Table_cell.new(cell.dup, row, column)
        table.push(table_cell)
      end
    end

    @top_left_struct = Table_cell.new(cell.dup, :top, :left)
    @top_left = top_left_struct.cell

    @top_middle_struct = Table_cell.new(cell.dup, :top, :middle)
    @top_middle = top_middle_struct.cell

    @top_right_struct = Table_cell.new(cell.dup, :top, :right)
    @top_right = top_right_struct.cell



    @middle_left_struct = Table_cell.new(cell.dup, :middle, :left)
    @middle_left = middle_left_struct.cell


    @middle_middle_struct = Table_cell.new(
      cell.dup, :middle, :middle)
    @middle_middle = middle_middle_struct.cell

    @middle_right_struct = Table_cell.new(cell.dup, :middle, :right)
    @middle_right = middle_right_struct.cell


    @bottom_left_struct = Table_cell.new(cell.dup, :bottom, :left)
    @bottom_left = bottom_left_struct.cell

    @bottom_middle_struct = Table_cell.new(cell.dup, :bottom, :middle)
    @bottom_middle = bottom_middle_struct.cell


    @bottom_right_struct = Table_cell.new(cell.dup, :bottom, :right)
    @bottom_right = bottom_right_struct.cell

    @previous_mark = nil #at the beginning, there's no previous mark

    #@top_left = cell.dup
    @top_left.set_row_top
    @top_left.set_column_left


    #@top_middle = cell.dup
    @top_middle.set_row_top
    @top_middle.set_column_middle

    #@top_right = cell.dup
    @top_right.set_row_top
    @top_right.set_column_right

    #@middle_left = cell.dup
    @middle_left.set_row_middle
    @middle_left.set_column_left

    #@middle_middle = cell.dup
    @middle_middle.set_row_middle
    @middle_middle.set_column_middle

    #@middle_right = cell.dup
    @middle_right.set_row_middle
    @middle_right.set_column_right

    #@bottom_left = cell.dup
    @bottom_left.set_row_bottom
    @bottom_left.set_column_left

    #@bottom_middle = cell.dup
    @bottom_middle.set_row_bottom
    @bottom_middle.set_column_middle

    #@bottom_right = cell.dup
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

  def mark(target)
    #translate target's string input to an object
    target = case target
             when "top_right" then top_right
             when "top_middle" then top_middle
             when "top_left" then top_left
             when "middle_right" then middle_right
             when "middle_middle" then middle_middle
             when "middle_left" then middle_left
             when "bottom_right" then bottom_right
             when "bottom_middle" then bottom_middle
             when "bottom_left" then bottom_left
             else
               #puts "tried to mark a bad target at #{self}"
               puts "bad input: try again (<row>_<column)"
               return
             end
    #if cell is not yet marked
    if target.content.nil?
      #mark the target cell depending on the previous mark
      if previous_mark == nil || previous_mark == 'O'
        target.mark_x
      elsif previous_mark == 'X'
        target.mark_o
      else
        puts "bad last mark at #{self}"
      end
      swap_previous_mark
    else
      puts "(board:) attempted to overwrite a cell, try again"
    end
  end
      
  def swap_previous_mark
    case self.previous_mark
    when nil then self.previous_mark = 'X'
    when 'O' then self.previous_mark = 'X'
    when 'X' then self.previous_mark = 'O'
    else
      p "error swapping previous mark at #{self}"
    end
      end

  def is_game_over
    cells = [
      top_right, top_middle, top_left,
      middle_right, middle_middle, middle_left,
      bottom_right, bottom_middle, bottom_left
    ]
    
    def not_nill_and_same(cells)
      #look at their marks..
      marks = cells.map {|cell| cell.content}
      #is none of them nil?
      no_nil_marks = marks.none? {|mark| mark.nil?}
      #are they all the same?
      all_marks_same = marks.uniq.count == 1 ? true : false
      no_nil_marks && all_marks_same
    end

    structs = [top_left_struct, top_middle_struct, top_right_struct,
               middle_left_struct, middle_middle_struct,
               middle_right_struct, bottom_left_struct,
               bottom_middle_struct, bottom_right_struct]


    rows = [:top, :middle, :bottom]
    for row in rows
      structs_to_scan = structs.select {|struct| struct.row == row}
      cells_to_scan = structs_to_scan.map{|struct| struct.cell}
      if not_nill_and_same(cells_to_scan)
        puts "hi from new loop at is_game_over"
        return true
      end
    end
    
    columns = [:left, :middle, :right]
    for column in columns
      structs_to_scan = structs.select {|struct|
        struct.column == column}
      cells_to_scan = structs_to_scan.map{|struct| struct.cell}
      if not_nill_and_same(cells_to_scan)
        puts "hi from new loop at is_game_over"
        return true
      end
    end
    #diagonals =
    #  forward_slash = /
    #  backslash = \
    forward_slash_diagonal = [bottom_left,
                              middle_middle,
                              top_right]
    if not_nill_and_same(forward_slash_diagonal)
      return true
    end
    
    backslash_diagonal = [bottom_right, middle_middle, top_left]
    if not_nill_and_same(backslash_diagonal)
      return true
    end
    
    return false
  end
end


class Cell
  private
  attr_writer :content

  public
  attr_reader :content

  def initialize
    @row = nil
    @column = nil
    @content = nil
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

  def overwrite_error
    puts "error: attempted to overwrite cell #{self}"
  end
  
  def printable
    if self.content.nil?
      self.row == 'bottom' ? ' ' : '_'
    else
      self.content
    end
  end
end


class Input
  #initialized with input (gets or other data)
  #can tell you if it's valid or not
  #can tell you which cell the input is targetting
  private
  attr_reader :input
  attr_writer :target
  
  public
  attr_reader :target
  def initialize(data)
    
    def process_input(input)
      processed_input = input
                          .to_s
                          .chomp
                          .downcase
    end
    
    @input = process_input(data)
    @target = nil
  end

  def valid?
    valid_inputs =
      [
        "top_left", "top_middle", "top_right",
        "middle_left", "middle_middle", "middle_right",
        "bottom_left", "bottom_middle", "bottom_right"
      ]
    valid_inputs.include?(input) ? true : false
  end

  def target
    self.valid? ? input : nil
  end
end

#pre-determined moves for testing
moves = ['top_left', 'top_middle',
         'middle_left', 'middle_middle',
         'bottom_right', 'bottom_middle',
        ]

bad_moves = ['top_left', 'top_left', 'top_right',
             'middle_left', 'middle_middle',
             'bottom_right', 'bottom_middle',
            ]
forward_slash = ['bottom_left', 'bottom_right',
                 'middle_middle','top_left',
                 'top_right',
                ]
backslash = ['bottom_right', 'bottom_middle',
             'middle_middle','top_middle',
             'top_left',
                ]

print_welcome_messages
board = Board.new(Cell.new())
board.display
#to test: change while loop to
#  for move in moves 
while not board.is_game_over 
  input = Input.new(gets) #can be a string instead of user input
  board.mark(input.target)
  board.display
end
puts "game over!"
