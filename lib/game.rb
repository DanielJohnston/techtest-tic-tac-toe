class Game
  def initialize
    # Each sub-array is one *column*, not row
    @board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @turn = :x
  end

  def board
    @board
  end

  def play across, down
    raise 'Outside of the board' unless inside_board?(across, down)
    raise 'Space already taken' if @board[across][down]
    @board[across][down] = :x
    switch_turns
  end

  def whose_turn
    @turn
  end

  private

  def switch_turns
    if @turn == :x
      @turn = :o
    else
      @turn = :x
    end
  end

  def inside_board? across, down
    [0, 1, 2].include?(across) && [0, 1, 2].include?(down)
  end
end
