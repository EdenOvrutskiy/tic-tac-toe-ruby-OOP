class Line_printer
  #prints two intersecting lines to the console
  def self.print
    puts "_|_|_"
    puts "_|_|_"
    puts " | | "
  end
end

Line_printer.print
#user_input = gets -> procedural

#factory: objects are instances of a class mindset:
#players make moves, (shared abstract concept)
#but each move is different (depending on which player did it (X or O?) and
#  the tile that was targetted.
class Move
  def initialize(player, tile)
    @player = player
    @tile = tile
  end
end
  
my_move  = Move.new("Eden", "top-left")
p my_move
