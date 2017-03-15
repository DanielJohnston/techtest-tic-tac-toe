class Game
  def initialize board
    @board = board
    @turn = :x
  end

  def board
    @board
  end

  def play across, down
    raise 'Game over' if game_over?
    @board.place @turn, across, down
    switch_turns
  end

  def whose_turn
    @turn
  end

  def winner
    return :x if @board.line_filled? :x
    return :o if @board.line_filled? :o
    false
  end

  def game_over?
    @board.line_filled? || @board.full?
  end

  private

  def switch_turns
    if @turn == :x
      @turn = :o
    else
      @turn = :x
    end
  end


end
