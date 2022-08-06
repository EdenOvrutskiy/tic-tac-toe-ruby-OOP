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
  attr_reader :table,
              :top_left_struct, :top_middle_struct,
              :top_right_struct,
              :middle_left_struct,
              :middle_middle_struct, :middle_right_struct,
              :bottom_left_struct, :bottom_middle_struct,
              :bottom_right_struct, :table_structs

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

    @top_middle_struct = Table_cell.new(cell.dup, :top, :middle)

    @top_right_struct = Table_cell.new(cell.dup, :top, :right)



    @middle_left_struct = Table_cell.new(cell.dup, :middle, :left)


    @middle_middle_struct = Table_cell.new(
      cell.dup, :middle, :middle)

    @middle_right_struct = Table_cell.new(cell.dup, :middle, :right)


    @bottom_left_struct = Table_cell.new(cell.dup, :bottom, :left)

    @bottom_middle_struct = Table_cell.new(cell.dup, :bottom, :middle)

    @bottom_right_struct = Table_cell.new(cell.dup, :bottom, :right)

    @table_structs = [
      top_left_struct, top_middle_struct,
      top_right_struct,
      middle_left_struct,
      middle_middle_struct, middle_right_struct,
      bottom_left_struct, bottom_middle_struct,
      bottom_right_struct
    ]
    
            

    @previous_mark = nil #at the beginning, there's no previous mark
  end

  def target_cell(row, column)
    if row.is_a? String
      row = row.to_sym
    end
    
    if column.is_a? String
      column = column.to_sym
    end
    
    begin
      #returns the cell at column, row
      #filter row
      row_structs = table_structs.select{|struct| struct.row == row}
      #filter column
      column_struct = row_structs.select do |struct|
        struct.column == column
      end
      cell_struct = column_struct.pop
      cell_object = cell_struct.cell
    rescue
      
      puts "tried to target a bad cell at #{self}, row: #{row}" <<
           "column: #{column}"
    end
  end
    
  def display
    def printable(cell, row)
      content = cell.content
      if content.nil?
        row == :bottom ? ' ' : '_'
      else
        content
      end
    end
    
    separator = '|'
    newline = "\n"
    row_column_pairs = [
      [:top, :left],    [:top,    :middle],    [:top, :right],
      [:middle, :left], [:middle, :middle], [:middle, :right],
      [:bottom, :left], [:bottom, :middle], [:bottom, :right]
    ]
    last_row = :bottom
    last_column = :right
    for pair in row_column_pairs
      row = pair[0]
      column = pair[1]
      cell = target_cell(row, column)
      print printable(cell,row)
      newline_or_separator = case column
                             when last_column then newline
                             else
                               separator
                             end
      print newline_or_separator
    end
    
  end

  def mark(target)
    #translate target's string input to an object
    #mark said cell depending on what the previous mark was.

    #expected input format: "row_column" string
    begin
      row_column_pair = target.split('_')
    rescue
      puts "mark could not parse target input"
      return false
    end
    row = row_column_pair[0]
    column = row_column_pair[1]

    target = target_cell(row, column)
    
    #if cell is not yet marked
    begin
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
    rescue
      puts "failed to mark cell"
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
    row_column_pairs = [
      [:top, :left],    [:top,    :middle],    [:top, :right],
      [:middle, :left], [:middle, :middle], [:middle, :right],
      [:bottom, :left], [:bottom, :middle], [:bottom, :right]
    ]
    cells = row_column_pairs.map do
      |pair| target_cell(pair[0], pair[1])
    end
    
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
        return true
      end
    end
    
    columns = [:left, :middle, :right]
    for column in columns
      structs_to_scan = structs.select {|struct|
        struct.column == column}
      cells_to_scan = structs_to_scan.map{|struct| struct.cell}
      if not_nill_and_same(cells_to_scan)
        return true
      end
    end
    #diagonals =
    #  forward_slash = /
    #  backslash = \
    forward_slash_diagonal = [target_cell(:bottom, :left),
                              target_cell(:middle, :middle),
                              target_cell(:top, :right)]
    
    backslash_diagonal = [target_cell(:bottom, :right),
                          target_cell(:middle, :middle),
                          target_cell(:top, :left)]
    
    for win_condition in [forward_slash_diagonal,
                          backslash_diagonal]
      if not_nill_and_same(win_condition)
        return true
      end
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
