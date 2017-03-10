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
  end
end
