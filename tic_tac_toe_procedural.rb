puts "welcome to tic tac toe"
puts "select a tile with the following syntax:"
puts "{row-position}"
puts "{top/middle/bottom}-{left/middle/right}"
puts "for example: 'top-middle'"
puts "X's turn"

def print_board
  puts "_|_|_"
  puts "_|_|_"
  puts " | | "
end

print_board
input = gets

