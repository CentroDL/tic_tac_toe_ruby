# modules
require_relative  "lib/renderable"

# classes
require_relative  "lib/keyboard"
require_relative  "lib/game"
require_relative  "lib/board"

tictactoe = Game.new
tictactoe.run
