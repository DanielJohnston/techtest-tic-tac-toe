require 'game'

describe Game do
  describe '#board' do
    it 'does not generate an error' do
      expect{ subject.board }.not_to raise_error
    end
  end
end
