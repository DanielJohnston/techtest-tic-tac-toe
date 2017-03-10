Dir[File.join(__dir__, 'lib', '*.rb')].each {|file| require file }

describe 'presents you with' do
  it 'an empty board' do
    game = Game.new
    expect(game.board).to eq [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
  end
end
