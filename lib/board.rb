class Board

  include Renderable
  attr_reader :values, :winner, :width, :position

  def initialize( width: 3)
    @width = width
    @values = Array.new(width)
    width.times do |n|
      values[n] = Array.new(3).fill(" ")
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

  # grid traversal methods
  # we check the movements before mutating position so it's not jittery when rendered
  # def move_up
  #   current_y = position[1] + 1
  #   position[1] = (current_y > (width - 1) ? 0 : current_y
  # end

  # def move_down
  # end

  # def move_right
  # end

  # def move_left
  # end

end

