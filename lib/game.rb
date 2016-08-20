require 'pry'
class Game

  include Renderable

  attr_accessor :board, :player, :computer, :keyboard, :players_turn

  def initialize( board: Board.new( width: 3) )
    @player = nil
    @computer = nil
    @players_turn = false
    @board = board
    @keyboard = Keyboard.new
  end

  def run
    start_game
    play_game
    end_game
  end

  private

  def start_game
    clear_screen

    puts welcome_prompt
    set_player_choice

    puts board_resize_prompt
    resize_board if player_says_yes?
  end

  def board_resize_prompt
    <<~PROMPT
      Would you like to resize the board?
      Default size is 3

      1) Yes  2) No

    PROMPT
  end

  def resize_board
    puts "How large would you like the board to be?"
    puts "Input a number (must be odd):"
    size = gets.chomp.to_i

    until size > 0 && size.odd?
      puts "Please input a positive odd number"
      size = gets.chomp.to_i
    end

    self.board = Board.new width: size

  end

  def end_game
    clear_screen
    puts endgame_prompt
    player_says_yes? ? reset_game : exit
  end

  def player_says_yes?
    valid_choices = ["1", "y", "Y", "yes", "YES", "2", "n", "N", "no", "NO"]
    player_choice = gets.chomp

    until valid_choices.include? player_choice
      puts "Please enter a valid choice (number or symbol)"
      player_choice = gets.chomp
    end

    case player_choice
      when "1", "y", "Y", "yes", "YES"
        true
      when "2", "n", "N", "no", "NO"
        false
      else
    end
  end

  # TODO: RESET THE BOARD
  def reset_game
    player = nil
    players_turn = false
    board.winner = nil
    run
  end

  def endgame_prompt
    <<~PROMPT

      Game Over!

      #{ "Winner: #{ board.winner ? board.winner : "DRAW" }"}

      Play Again?

      1) Yes  2) No

    PROMPT
  end

  def set_player_choice
    valid_choices = ["1", "X", "x", "2", "O", "o"]
    player_choice = gets.chomp

    until valid_choices.include? player_choice
      puts "Please enter a valid choice (number or symbol)"
      player_choice = gets.chomp
    end


    case player_choice
      when "1", "X", "x"
        @player   = "X"
        @computer = "O"
      when "2", "O", "o"
        @player   = "O"
        @computer = "X"
      else
        @player = nil
    end

    self.players_turn = player == "X"
  end

  def welcome_prompt
    <<~PROMPT

      Hello, Welcome to Tic Tac Toe!

      What side would you like?

      1) X
      2) O
    PROMPT
  end

  def play_game

    until board.winner || board.draw
      board.render
      if players_turn
        get_player_input
      else
        get_computer_input
      end
      board.detect_win
    end

  end

  def get_player_input
    while players_turn do
      input = keyboard.listen

      case input
      when "\e[A"
        board.move_up
        break
      when "\e[B"
        board.move_down
        break
      when "\e[C"
        board.move_right
        break
      when "\e[D"
        board.move_left
        break
      when "\r"
        if board.place(player)
          self.players_turn = false
        end
        break
      when "\u0003"
        exit
      else
      end
    end

  end

  def get_computer_input
    board.position = [0,0]
    board.place(computer)
    players_turn = true
  end

end



