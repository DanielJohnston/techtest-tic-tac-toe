Dir[File.join(__dir__, 'lib', '*.rb')].each {|file| require file }

describe 'play a game of tic tac toe' do
  it 'to a draw' do
    game = Game.new
    [1, 2, 0].each_with_index do |across|
      (0..2).each_with_index do |down|
        game.play across, down
      end
    end
    expect(game).to be_game_over
    expect(game.winner).to be false
  end

  it 'until O wins' do
    game = Game.new
    game.play(0, 0)
    game.play(1, 0)
    game.play(0, 2)
    game.play(1, 1)
    game.play(2, 0)
    game.play(1, 2)
    expect(game).to be_game_over
    expect(game.winner).to be :o
  end
end
