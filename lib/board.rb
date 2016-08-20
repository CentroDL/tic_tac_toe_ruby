class Board

  include Renderable
  attr_accessor :values, :winner, :width, :position

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
    puts message unless message.nil?

  end

  def draw_line
    # noticed the offset was the lowest even number prior so that's that i subtract the multiplier by
    puts "-" * ( (width * 5) - (width-1)   )
  end


  def place(input)
    current_value = values[position[0]][position[1]]
    if current_value == " "
      values[position[0]][position[1]] = input
    else
      false
    end
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

  def search_for_rows
    scan_rows values
    scan_rows values.transpose
    scan_rows diagonals
  end

  def scan_rows(rows)
    rows.each do |row|
      @winner = row.first if row.uniq.length == 1 && row.first != " "
    end
  end

  # def columns
  #   columns = []

  #   (0..width-1).each do |index|
  #     columns << values.collect { |row| row[index] }
  #   end

  #   columns
  # end

  def diagonals
    diagonals = []

    top_left_bottom_right = values.collect.with_index { |row, id| row[id] }
    diagonals << top_left_bottom_right

    bottom_left_top_right = values.reverse.collect.with_index { |row, id| row[id] }
    diagonals << bottom_left_top_right

    diagonals
  end

end

