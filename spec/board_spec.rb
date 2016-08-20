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

  describe "#values_full?" do

    it "should be true when board is full" do
      full_board = Board.new
      full_board.values.each { |row| row.fill("V") }
      expect( full_board.values_full? ).to eq(true)
    end

    it "should be false when board isn't full" do
      empty_board = Board.new
      expect( empty_board.values_full? ).to eq(false)

      skim_board = Board.new
      skim_board.position = [1,2]
      skim_board.place "P"
      expect( skim_board.values_full? ).to eq(false)
    end

  end

  describe "#detect_win" do
    it "detects a draw on a deadlocked board" do
      deadlocked_board = Board.new
      deadlocked_board.values[0] = [1,2,3]
      deadlocked_board.values[1] = [4,5,6]
      deadlocked_board.values[2] = [7,8,9]
      deadlocked_board.detect_win

      expect(deadlocked_board.winner).to eq(nil)
      expect(deadlocked_board.draw).to eq(true)
    end

    it "detects horizontal rows" do
      horizontally_won = Board.new
      horizontally_won.values[1] = ["X", "X", "X"]
      horizontally_won.detect_win

      expect(horizontally_won.winner).to eq("X")
    end

    it "detects vertical rows" do
      vertically_won = Board.new
      row = [" ", "O", " "]
      vertically_won.values[0] = row
      vertically_won.values[1] = row
      vertically_won.values[2] = row
      vertically_won.detect_win

      expect(vertically_won.winner).to eq("O")
    end

    it "detects diagonal wins" do
      diagonally_won = Board.new
      diagonally_won.values[0] = ["X", "O", " "]
      diagonally_won.values[1] = ["O", "X", "O"]
      diagonally_won.values[2] = ["O", " ", "X"]
      diagonally_won.detect_win

      expect(diagonally_won.winner).to eq("X")

      diagonally_won = Board.new
      diagonally_won.values[0] = ["X", "O", "C"]
      diagonally_won.values[1] = ["O", "C", "O"]
      diagonally_won.values[2] = ["C", " ", "X"]
      diagonally_won.detect_win

      expect(diagonally_won.winner).to eq("C")
    end

  end


end
