require 'board'

describe Board do
  describe '#state' do
    it 'does not generate an error' do
      expect{ subject.state }.not_to raise_error
    end

    it 'returns an empty 3x3 board by default' do
      expect(subject.state).to eq [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    end

    it 'returns an empty 4x5 board when set up appropriately' do
      board = Board.new width=4, height=5
      expect(board.state).to eq [[nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil]]
    end
  end

  describe '#place' do
    let(:player_x) { double :player_x }
    let(:player_y) { double :player_y }

    it 'accepts a move' do
      expect { subject.place(player_x, 0, 0) }.not_to raise_error
    end

    it 'updates the board state when a move is played in top left' do
      subject.place(player_x, 0, 0)
      expect(subject.state).to eq [[player_x, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    end

    it 'updates the board state when a move is played in the middle' do
      subject.place(player_x, 1, 1)
      expect(subject.state).to eq [[nil, nil, nil], [nil, player_x, nil], [nil, nil, nil]]
    end

    it 'cannot play a move to the right of the board area' do
      expect{ subject.place(player_x, 3, 0) }.to raise_error 'Outside of the board'
    end

    it 'cannot play a move below the board area' do
      expect{ subject.place(player_x, 0, 3) }.to raise_error 'Outside of the board'
    end

    it 'cannot play a move to the left of the board area' do
      expect{ subject.place(player_x, -1, 0) }.to raise_error 'Outside of the board'
    end

    it 'cannot play a move above the board area' do
      expect{ subject.place(player_x, 0, -1) }.to raise_error 'Outside of the board'
    end

    it 'cannot play a move in an already played field' do
      subject.place(player_x, 0, 0)
      expect{ subject.place(player_y, 0, 0) }.to raise_error 'Space already taken'
    end

    it 'stores a player_x when player X plays' do
      subject.place(player_x, 0, 0)
      subject.place(player_y, 1, 1)
      subject.place(player_x, 2, 2)
      expect(subject.state[2][2]).to eq player_x
    end

    it 'stores a player_y when player Y plays' do
      subject.place(player_x, 0, 0)
      subject.place(player_y, 1, 1)
      expect(subject.state[1][1]).to eq player_y
    end
  end

  describe '#line_filled' do
    let(:player_x) { double :player_x }
    let(:player_y) { double :player_y }

    it 'is false at the beginning' do
      expect(subject).not_to be_line_filled
    end

    it 'is false when a complete game is played with no three-in-a-row' do
      [[0, 0], [0, 1], [1, 2], [2, 0], [2, 1]].each { |loc| subject.place(player_x, loc[0], loc[1])}
      [[0, 2], [1, 0], [1, 1], [2, 2]].each { |loc| subject.place(player_y, loc[0], loc[1])}
      expect(subject.line_filled?).to be false
    end

    it '(player_x) is true when X plays three in a row horizontally' do
      subject.place(player_x, 0, 0)
      subject.place(player_y, 0, 1)
      subject.place(player_x, 1, 0)
      subject.place(player_y, 1, 1)
      subject.place(player_x, 2, 0)
      expect(subject.line_filled?(player_x)).to be true
    end

    it '(player_y) is true when O plays three in a row vertically' do
      subject.place(player_x, 0, 0)
      subject.place(player_y, 1, 0)
      subject.place(player_x, 0, 2)
      subject.place(player_y, 1, 1)
      subject.place(player_x, 2, 0)
      subject.place(player_y, 1, 2)
      expect(subject.line_filled?(player_y)).to be true
    end

    it '(player_x) is true when X plays three in a row diagonally' do
      subject.place(player_x, 0, 0)
      subject.place(player_y, 1, 0)
      subject.place(player_x, 1, 1)
      subject.place(player_y, 2, 1)
      subject.place(player_x, 2, 2)
      expect(subject.line_filled?(player_x)).to be true
    end
  end

  describe '#full?' do
    let(:player_x) { double :player_x }
    let(:player_y) { double :player_y }

    it 'is false when a complete game is not played' do
      [[0, 0], [0, 1], [1, 2], [2, 0]].each { |loc| subject.place(player_x, loc[0], loc[1])}
      [[0, 2], [1, 0], [1, 1], [2, 2]].each { |loc| subject.place(player_y, loc[0], loc[1])}
      expect(subject.full?).to be false
    end      

    it 'is true when a complete game is played' do
      [[0, 0], [0, 1], [1, 2], [2, 0], [2, 1]].each { |loc| subject.place(player_x, loc[0], loc[1])}
      [[0, 2], [1, 0], [1, 1], [2, 2]].each { |loc| subject.place(player_y, loc[0], loc[1])}
      expect(subject.full?).to be true
    end
  end
end
