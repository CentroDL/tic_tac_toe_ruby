# modules
require_relative  "lib/renderable.rb"

# classes
require_relative  "lib/keyboard.rb"
require_relative  "lib/game.rb"
require_relative  "lib/board.rb"

tictactoe = Game.new(board: Board.new(width: 5))
tictactoe.run

# board3 = Board.new
# board5 = Board.new width: 5
# board3.render
# board5.render


# read a character without pressing enter and without printing to the screen
# def read_char

# end

# takes a single character command
# def show_single_key
#     c = read_char
#   case c
#   when " "
#     puts "SPACE"
#   when "\t"
#     puts "TAB"
#   when "\r"
#     puts "RETURN"
#   when "\n"
#     puts "LINE FEED"
#   when "\e"
#     puts "ESCAPE"
#   when "\e[A"
#     puts "UP ARROW"
#   when "\e[B"
#     puts "DOWN ARROW"
#   when "\e[C"
#     puts "RIGHT ARROW"
#   when "\e[D"
#     puts "LEFT ARROW"
#   when "\177"
#     puts "BACKSPACE"
#   when "\004"
#     puts "DELETE"
#   when "\u0003"
#     exit
#   when /^.$/
#     puts "SINGLE CHAR HIT: #{c.inspect}"
#   else
#     puts "SOMETHING ELSE: #{c.inspect}"
#   end
# end

# show_single_key while(true)
