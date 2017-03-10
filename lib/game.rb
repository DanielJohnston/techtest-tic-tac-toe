class Game
  def initialize
    # Each sub-array is one *column*, not row
    @board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
  end

  def board
    @board
  end

  def play across, down
    raise 'Outside of the board' unless inside_board?(across, down)
    @board[across][down] = :x
  end

  def inside_board? across, down
    [0, 1, 2].include?(across) && [0, 1, 2].include?(down)
  end
end
