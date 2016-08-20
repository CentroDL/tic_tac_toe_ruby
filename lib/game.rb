class Game

  include Renderable
  attr_accessor :board, :player, :players_turn, :computer, :keyboard

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
  end

  def end_game
    clear_screen
    puts endgame_prompt
    play_again? ? reset_game : exit
  end

  def play_again?
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

  def reset_game
    @player = nil
    start_game
  end

  def endgame_prompt
    <<~PROMPT

      Game Over!

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

    @players_turn = @player == "X"
    puts "Player has chosen #{ @player }"
    puts "Comupter will be #{ @computer }"
  end

  def welcome_prompt
    <<~PROMPT

      Hello, Welcome to Tic Tac Toe!

      What side would you like?

      1) X
      2) O
    PROMPT
  end

  def winner_detected?
    false
    # board.row_detected
  end


  def play_game
    until board.winner
      board.render
      if players_turn
        get_player_input
      else
        get_computer_input
      end
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
          board.place(player)
          break
        when "\004"
          puts "DELETE"
        when "\u0003"
          exit
      end

    end
  end



end



