class Board

  include Renderable
  attr_reader :values, :winner, :width, :position

  def initialize( width: 3)
    @width = width
    @values = Array.new(width)
    width.times do |n|
      values[n] = Array.new(width).fill(" ")
    end
    @winner = nil
    @position = [0,0]
  end

  def render( message: nil)
    clear_screen
    draw_line

    values.each_with_index do |row, x|
      output = "|"
      row.each_with_index do |value, y|
        output += [x,y] == position ? "{#{value}}" : " #{value} "
        output += "|"
      end
      puts output
      draw_line
    end

    puts position
    puts message if !message.nil?

  end

  def draw_line
    # noticed the offset was the lowest even number prior so that's that i subtract the multiplier by
    puts "-" * ( (width * 5) - (width-1)   )
  end


  def place(input)
    values[position[0]][position[1]] = input
  end

  # grid traversal methods
  # we check the movements before mutating position so it's not jittery when rendered
  def move_up
    current_y = position[0] - 1
    position[0] = (current_y < 0 ) ? (width-1) : current_y
  end

  def move_down
    current_y = position[0] + 1
    position[0] = (current_y > (width - 1)) ? 0 : current_y
  end

  def move_right
    current_x = position[1] + 1
    position[1] = (current_x > (width - 1)) ? 0 : current_x
  end

  def move_left
    current_x = position[1] - 1
    position[1] = (current_x < 0) ? (width-1) : current_x
  end

end

