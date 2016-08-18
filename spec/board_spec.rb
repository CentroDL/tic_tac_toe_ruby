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

  context 'when created' do

    xit "ensures an odd width" do

    end

  end

end
