require 'pry'

def print_welcome_messages
  puts "welcome to tic tac toe"
  puts "select a tile with the following syntax:"
  puts "{row_column}"
  puts "{top/middle/bottom}-{left/middle/right}"
  puts "for example: 'top_middle'"
end


class Board
  private
  attr_accessor :previous_mark
  attr_reader :table
  
  public
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

    @previous_mark = nil #at the beginning, there's no previous mark
  end

  
  def target_cell(row, column)
    #takes in symbols representing row / column
    #returns the cell object at column, row of table.
    begin
      #select the table structs that have the specified row
      row_structs = table.select{|struct| struct.row == row}
      #select the table struct that has the specified column
      column_struct = row_structs.select do |struct|
        struct.column == column
      end
      #it's in an array, pop it out
      cell_struct = column_struct.pop
      #target the cell object in the struct
      cell_object = cell_struct.cell
    rescue
      
      puts "tried to target a bad cell at #{self}, row: #{row}" <<
           "column: #{column}"
    end
  end

  def display
    def printable(cell, row)
      if not cell.marked?
        row == :bottom ? ' ' : '_'
      else
        cell.content
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
      row, column = pair
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
    #map the string "target" into the correct cell on the board
    #mark with X / O depending on what the previous mark is.

    #expected input format: "row_column" (string)
    def process_user_input(input)
      #takes string input from user
      #returns valid cell-object
      begin
        processed_input = input
                            .to_s
                            .chomp
                            .downcase
                            .split('_')
        row, column = processed_input
        row = row.to_sym
        column = column.to_sym
        target = target_cell(row, column)
      rescue
        puts "mark could not parse target input"
        false
      end
    end
    
    target = process_user_input(target)
    return unless target
    
    begin
      #if cell is not yet marked
      if not target.marked?
        #mark the target cell depending on the previous mark
        if previous_mark.nil? || previous_mark == 'O'
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
    
    def do_structs_share_mark?(structs)
      cells = extract_cells(structs)
      do_cells_share_mark?(cells)
    end
    
    def do_cells_share_mark?(cells)
      #check if cells are marked
      cells_marked = cells.all? {|cell| cell.marked?}
      #are they all the same?
      marks = cells.map {|cell| cell.content}
      all_marks_same = marks.uniq.count == 1 ? true : false
      cells_marked && all_marks_same
    end

    def extract_cells(structs)
      structs.map{|struct| struct.cell}
    end
    

    rows = [:top, :middle, :bottom]
    for row in rows
      structs_to_scan = table.select {|struct| struct.row == row}
      return true if do_structs_share_mark?(structs_to_scan)
    end
    
    columns = [:left, :middle, :right]
    for column in columns
      structs_to_scan = table.select {|struct|
        struct.column == column}
      return true if do_structs_share_mark?(structs_to_scan)
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
      if do_cells_share_mark?(win_condition)
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
    if not self.marked? then self.content = 'X'
    else
      overwrite_error
    end
  end

  def mark_o
    if not self.marked? then self.content = 'O'
    else
      overwrite_error
    end
  end

  def marked?
    self.content.nil? ? false : true
  end

  def overwrite_error
    puts "error: attempted to overwrite cell #{self}"
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
  board.mark(gets)
  board.display
end
puts "game over!"
