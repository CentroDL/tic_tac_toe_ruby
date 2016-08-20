require_relative '../lib/renderable'
require_relative '../lib/board'

describe Board do


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
      # |{C}| C |0,2|
      # -------------
      # | C | C |1,2|
      # -------------
      # | C |2,1| C |
      # -------------

      empty_spaces = [ [0,2], [1,2], [2,1] ]

      expect(board.empty_coords).to eq( empty_spaces )
    end
  end

  context 'when created' do

    it "creates a square board to play on" do
      # there are several assertions but for the same feature
      three_tile_board = Board.new width: 3

      expect( three_tile_board.values.length ).to eq( 3 )
      expect( three_tile_board.values.first.length ).to eq( 3 )

      five_tile_board  = Board.new width: 5

      expect( five_tile_board.values.length ).to eq( 5 )
      expect( five_tile_board.values.first.length ).to eq( 5 )
    end

    xit "ensures an odd width" do
      # decided to sanitize input externally
    end

  end

  context "when traversing the grid" do
    let(:surfboard) { Board.new width: 3}
    describe "#move_up" do
      it "moves the position up" do
        surfboard.position = [1,1]
        surfboard.move_up
        expect(surfboard.position).to eq( [0,1] )
      end

      it "goes the the bottom when it goes past the top" do
        surfboard.position = [0,0]
        surfboard.move_up
        expect(surfboard.position).to eq( [2,0] )
      end
    end

    describe "#move_down" do
      it "moves the position down" do
        surfboard.position = [0,0]
        surfboard.move_down
        expect(surfboard.position).to eq( [1,0] )
      end

      it "goes to the top if it goes past the bottom" do
        surfboard.position = [2,0]
        surfboard.move_down
        expect(surfboard.position).to eq( [0,0] )
      end
    end

    describe "#move_left" do
      it "moves the position left" do
        surfboard.position = [1,1]
        surfboard.move_left
        expect(surfboard.position).to eq( [1,0] )
      end

      it "goes to the right if it goes past the left" do
        surfboard.position = [1,0]
        surfboard.move_left
        expect(surfboard.position).to eq( [1,2] )
      end
    end

    describe "#move_right" do
      it "moves the position right" do
        surfboard.position = [1,1]
        surfboard.move_right
        expect(surfboard.position).to eq( [1,2] )
      end

      it "goes to the left if it goes past the right" do
        surfboard.position = [1,2]
        surfboard.move_right
        expect(surfboard.position).to eq( [1,0] )
      end
    end
  end

end
