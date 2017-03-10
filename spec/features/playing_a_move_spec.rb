Dir[File.join(__dir__, 'lib', '*.rb')].each {|file| require file }

describe 'on the first turn' do
  it 'lets the current player play a move' do
    game = Game.new
    expect{ game.play(0, 0) }.not_to raise_error
  end
end
