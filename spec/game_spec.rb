require 'game'

describe Game do
  describe '#board' do
    it 'does not generate an error' do
      expect{ subject.board }.not_to raise_error
    end

    it 'returns an empty board' do
      expect(subject.board).to eq [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    end
  end

  describe '#play' do
    it 'accepts a move' do
      expect { subject.play(0, 0) }.not_to raise_error
    end

    it 'updates the board state when X is played in top left' do
      subject.play(0, 0)
      expect(subject.board).to eq [[:x, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    end

    it 'updates the board state when X is played in the middle' do
      subject.play(1, 1)
      expect(subject.board).to eq [[nil, nil, nil], [nil, :x, nil], [nil, nil, nil]]
    end

    it 'cannot play a move to the right of the board area' do
      expect{ subject.play(3, 0) }.to raise_error 'Outside of the board'
    end

    it 'cannot play a move below the board area' do
      expect{ subject.play(0, 3) }.to raise_error 'Outside of the board'
    end

    it 'cannot play a move to the left of the board area' do
      expect{ subject.play(-1, 0) }.to raise_error 'Outside of the board'
    end

    it 'cannot play a move above the board area' do
      expect{ subject.play(0, -1) }.to raise_error 'Outside of the board'
    end

    it 'cannot play a move in an already played field' do
      subject.play(0, 0)
      expect{ subject.play(0, 0) }.to raise_error 'Space already taken'
    end

    it 'stores an :x when player X plays' do
      subject.play(0, 0)
      subject.play(1, 1)
      subject.play(2, 2)
      expect(subject.board[2][2]).to eq :x
    end

    it 'stores an :o when player O plays' do
      subject.play(0, 0)
      subject.play(1, 1)
      expect(subject.board[1][1]).to eq :o
    end
  end

  describe '#whose_turn' do
    it 'begins with player X' do
      expect(subject.whose_turn).to eq :x
    end
    it 'switches to player O after 1 turn' do
      subject.play(0, 0)
      expect(subject.whose_turn).to eq :o
    end
    it 'switches back to player X after 2 turns' do
      subject.play(0, 0)
      subject.play(1, 1)
      expect(subject.whose_turn).to eq :x
    end
  end
end
