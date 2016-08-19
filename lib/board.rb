class Board

  include Renderable
  attr_reader :values, :winner, :width

  def initialize( width: 3)
    @width = width
    @values = Array.new(width).fill( Array.new(width).fill(" ") )
    @winner = nil
  end

  def render
    clear_screen
    draw_line

    values.each do |row|
      output = "|"
      row.each do |value|
        output += " #{value} |"
      end
      puts output
      draw_line
    end

  end

  def draw_line
    # noticed the offset was the lowest even number prior so that's that i subtract the multiplier by
    puts "-" * ( (width * 5) - (width-1)   )
  end



end

