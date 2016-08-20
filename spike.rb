# modules
require_relative  "lib/renderable"

# classes
require_relative  "lib/keyboard"
require_relative  "lib/game"
require_relative  "lib/board"

tictactoe = Game.new
tictactoe.run

# board3 = Board.new
# board5 = Board.new width: 5
# board3.render
# board5.render
