require 'game'
# require 'pry'

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

    it 'cannot play when the game is over' do
      allow(subject).to receive(:game_over?) { true }
      expect{ subject.play(0, 0) }.to raise_error 'Game over'
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

  describe '#three_in_a_row' do
    it 'is false at the beginning' do
      expect(subject).not_to be_three_in_a_row
    end

    it 'is false when a complete game is played with no three-in-a-row' do
      [1, 2, 0].each_with_index do |across|
        (0..2).each_with_index do |down|
          subject.play across, down
        end
      end
      expect(subject.three_in_a_row?).to be false
    end

    it '(:x) is true when X plays three in a row horizontally' do
      subject.play(0, 0)
      subject.play(0, 1)
      subject.play(1, 0)
      subject.play(1, 1)
      subject.play(2, 0)
      expect(subject.three_in_a_row?(:x)).to be true
    end

    it '(:o) is true when O plays three in a row vertically' do
      subject.play(0, 0)
      subject.play(1, 0)
      subject.play(0, 2)
      subject.play(1, 1)
      subject.play(2, 0)
      subject.play(1, 2)
      expect(subject.three_in_a_row?(:o)).to be true
    end

    it '(:x) is true when X plays three in a row diagonally' do
      subject.play(0, 0)
      subject.play(1, 0)
      subject.play(1, 1)
      subject.play(2, 1)
      subject.play(2, 2)
      expect(subject.three_in_a_row?(:x)).to be true
    end
  end

  describe '#winner' do
    it 'returns false at the beginning of the game' do
      expect(subject.winner).to be false
    end

    it 'returns :x when X plays three in a row horizontally' do
      subject.play(0, 0)
      subject.play(0, 1)
      subject.play(1, 0)
      subject.play(1, 1)
      subject.play(2, 0)
      expect(subject.winner).to be :x
    end

    it 'returns :o when O plays three in a row vertically' do
      subject.play(0, 0)
      subject.play(1, 0)
      subject.play(0, 2)
      subject.play(1, 1)
      subject.play(2, 0)
      subject.play(1, 2)
      expect(subject.winner).to be :o
    end

    it 'returns :x when X plays three in a row diagonally' do
      subject.play(0, 0)
      subject.play(1, 0)
      subject.play(1, 1)
      subject.play(2, 1)
      subject.play(2, 2)
      expect(subject.winner).to be :x
    end
  end

  describe '#game_over?' do
    it 'returns false at the beginning of the game' do
      expect(subject).to_not be_game_over
    end

    it 'returns false in mid-game' do
      subject.play(0, 0)
      subject.play(0, 1)
      subject.play(1, 0)
      subject.play(1, 1)
      expect(subject).to_not be_game_over
    end

    it 'returns true when X has three in a row' do
      subject.play(0, 0)
      subject.play(0, 1)
      subject.play(1, 0)
      subject.play(1, 1)
      subject.play(2, 0)
      expect(subject).to be_game_over
    end

    it 'returns true when O has three in a row' do
      subject.play(0, 0)
      subject.play(1, 0)
      subject.play(0, 2)
      subject.play(1, 1)
      subject.play(2, 0)
      subject.play(1, 2)
      expect(subject).to be_game_over
    end

    it 'returns true when the board is full' do
      [1, 2, 0].each_with_index do |across|
        (0..2).each_with_index do |down|
          subject.play across, down
        end
      end
      expect(subject).to be_game_over
    end
  end
end
