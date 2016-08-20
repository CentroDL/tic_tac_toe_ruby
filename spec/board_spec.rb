require_relative '../lib/renderable.rb'
require_relative '../lib/board.rb'

describe Board do

  it "creates a square board to play on" do
    # there are several assertions but for the same feature
    three_tile_board = Board.new width: 3

    expect( three_tile_board.values.length ).to eq( 3 )
    expect( three_tile_board.values.first.length ).to eq( 3 )

    five_tile_board  = Board.new width: 5

    expect( five_tile_board.values.length ).to eq( 5 )
    expect( five_tile_board.values.first.length ).to eq( 5 )
  end

  describe "#empty_coords" do
    it "collects the coordinates of all empty spaces" do
      board = Board.new
      board.values[0][0] = "C"
      board.values[0][1] = "C"
      board.values[1][1] = "C"
      board.values[1][0] = "C"
      board.values[2][0] = "C"
      board.values[2][2] = "C"
      # -------------
      # |{C}| C |   |
      # -------------
      # | C | C |   |
      # -------------
      # | C |   | C |
      # -------------

      empty_spaces = [ [0,2], [1,2], [2,1] ]

      expect(board.empty_coords).to eq( empty_spaces )
    end
  end

  context 'when created' do

    xit "ensures an odd width" do

    end

  end

end
