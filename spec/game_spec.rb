require 'game'

describe Game do
  subject { Game.new(board) }
  let(:board) { double(:board) }

  describe '#play' do
    it 'accepts and passes on a move' do
      allow(board).to receive(:line_filled?).and_return false
      allow(board).to receive(:full?).and_return false
      expect(board).to receive(:place).with(:x, 0, 0)
      subject.play(0, 0)
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
      allow(board).to receive(:place)
      allow(subject).to receive(:game_over?) { false }
      subject.play(0, 0)
      expect(subject.whose_turn).to eq :o
    end

    it 'switches back to player X after 2 turns' do
      allow(board).to receive(:place)
      allow(subject).to receive(:game_over?) { false }
      subject.play(0, 0)
      subject.play(1, 1)
      expect(subject.whose_turn).to eq :x
    end
  end

  describe '#winner' do
    it 'returns false at the beginning of the game' do
      allow(board).to receive(:line_filled?).and_return false
      expect(subject.winner).to be false
    end

    it 'returns :x when X has a filled line' do
      allow(board).to receive(:line_filled?).with(:x).and_return true
      allow(board).to receive(:line_filled?).with(:o).and_return false
      expect(subject.winner).to be :x
    end

    it 'returns :y when Y has a filled line' do
      allow(board).to receive(:line_filled?).with(:x).and_return false
      allow(board).to receive(:line_filled?).with(:o).and_return true
      expect(subject.winner).to be :o
    end
  end

  describe '#game_over?' do
    it 'returns false when the board has nothing all in a line and is not full' do
      allow(board).to receive(:line_filled?).and_return false
      allow(board).to receive(:full?).and_return false
      expect(subject).to_not be_game_over
    end

    it 'returns true when a player has a full line' do
      allow(board).to receive(:line_filled?).and_return true
      allow(board).to receive(:full?).and_return false
      expect(subject).to be_game_over
    end

    it 'returns true when the board is full' do
      allow(board).to receive(:line_filled?).and_return false
      allow(board).to receive(:full?).and_return true
      expect(subject).to be_game_over
    end
  end
end
