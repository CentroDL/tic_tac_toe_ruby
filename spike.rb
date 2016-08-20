# modules
require_relative  "lib/renderable.rb"

# classes
require_relative  "lib/keyboard.rb"
require_relative  "lib/game.rb"
require_relative  "lib/board.rb"

tictactoe = Game.new
tictactoe.run

# board3 = Board.new
# board5 = Board.new width: 5
# board3.render
# board5.render
