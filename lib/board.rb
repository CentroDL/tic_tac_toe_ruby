class Board

  attr_reader :values

  def initialize( width: 2)
    @values = Array.new(width).fill( Array.new(width).fill("P") )
  end

end

