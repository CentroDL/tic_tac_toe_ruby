[![Build Status](https://travis-ci.org/CentroDL/tic_tac_toe_ruby.svg?branch=master)](https://travis-ci.org/CentroDL/tic_tac_toe_ruby)

# Tic Tac Toe in Ruby

![A tic tac toe gif][ttt_gif]

This is a tic tac toe terminal game written in ruby using no third party gems.

## Dependencies

- Ruby 2.3.1 (Syntax)
- Development:
- pry
- rspec
- guard

## Setup

If you have to set Ruby versions refer to your installed version manager:

|rvm|rbenv|
|:---:|:---:|
|`rvm install 2.3.1`<br>`rvm use 2.3.1` |`rbenv install 2.3.1`<br>`rbenv local 2.3.1`|


1. Clone this repository onto your computer and run `bundle exec bundle install`
1. To run the game, run `ruby tictactoe.rb`
1. Refer to the [Tic-Tac-Toe Wiki](https://en.wikipedia.org/wiki/Tic-tac-toe) if you're unsure of the rules.

# To Play

Prompts will appear on the screen, they accept either the number or value provided. Type what you want to happen and press `return/enter`

Once in the game, move with the arrow keys and press `enter/return` to place your piece.

Hit `ctrl + c` to quit at any time.

## Design

There are three classes in this program. A `Game` object that is composed of an `Input` object, and a `Board` object. A `Renderable` module was written to help any elements that coud draw to the screen.

The `Game` class is in charge of running the game, sequencing actions/inputs, and managing states and actors.

The `Board` class handles the state of the tic tac toe board, and is in charge of rendering itself, placing symbols, and detecting wins/draws.

The `Input` class wraps the logic that talks to the keyboard (STDIN). This was needed to get arrow keys and enter presses.

The `Renderable` module houses utility methods for outputting to the terminal. At this moment it's just used to clear the screen. So whatever object that's using it can redraw the game state in place.

## Challenges
Designing the object pattern for this was difficult for a number of reasons. In game development, logic and rendering are very separate and a clear pipeline usually exists for objects to talk to a renderer class. Since this is a terminal game, all of the objects can inherently print text via STDOUT and can render themselves, blurring the separation of concerns. Instead of a `Renderer` class I settled for a module so that any other object could fulfill the role of something that draws to the screen in place. Write now both the `Game` and `Board` classes are *renderable*.

In order to detect arrow/enter keys for input, an `Input` class was written to listen to special key inputs that a regular `getch`/`gets` couldn't detect. This was challenging since I wasn't going to use any third party gems like the popular [Curses module](https://github.com/ruby/curses), but as of Ruby 2.1.0 it has been removed from the Ruby standard library. So instead of downgrading to an insecure version of Ruby I referred to a [guide by Alec Jacobson][alecjacobson]. There's a thread creation & sleep in there that is not the most elegant but it beats diving into C++ with a time constraint.

The object structure isn't what I'd normally do, but this was a fun project with a time constraint. If I were to expand on this, I'd probably create a `TicTacToe` class that inherits from `Game`, but handles more of the tic-tac-toe specific logic. The `Game` class itself feels overly large. There are a lot of messages/states that I feel could be extracted out.

I feel like there could be a `Player` class that can keep track of its own positions, symbols, movements, decisions, and placement, but since they'd still need to talk to the `Board` object their location in the code really wouldn't change.

There could also be a `Computer` class that inherits from the player class, as they share many attributes, but could be extended with some better automated playmaking. At the moment it asks the board to give all of the coordinates of empty spaces and randomly picks one to draw on, and that shouldn't be the job of the `Board` class.

In the future I'd likely increase test coverage to the other classes. I only unit tested the Board class since it was the most concrete, and the `Game` class doesn't really  have any dynamic behavior. There also weren't any integration tests, but I am still learning how to write them well.

All in all I had a ton of fun with this project, enjoy!

### References

- [Alec Jacobson's guide on character input][alecjacobson]


[alecjacobson]: http://www.alecjacobson.com/weblog/?p=75
[ttt_gif]: https://media.giphy.com/media/ZOkZMEY7SgozC/giphy.gif
