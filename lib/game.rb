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
    @board[across][down] = @turn
    switch_turns
  end

  def whose_turn
    @turn
  end

  def three_in_a_row? player = :all
    # Check for either player if neither is given
    return three_in_a_row?(:x) || three_in_a_row?(:o) if player == :all
    # Check horizontals
    return true if @board.any? { |row| row.all? { |field| field == player }}
    # Check verticals
    return true if @board.transpose.any? { |column| column.all? { |field| field == player }}
    # Check diagonals
    return true if (0..2).collect{ |i| @board[i][i] }.all? { |field| field == player }
    return true if (0..2).collect{ |i| @board[2-i][i] }.all? { |field| field == player }
    false
  end

  def winner
    return :x if three_in_a_row? :x
    return :o if three_in_a_row? :o
    false
  end

  private

  def all_x_or_o? fields
    fields.all?{ |field| field == :x } || fields.all?{ |field| field == :o }
  end

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
