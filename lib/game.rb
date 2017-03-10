class Game
  def initialize
    @board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
  end

  def board
    @board
  end

  def play across, down
    @board[across][down] = :x
  end
end
