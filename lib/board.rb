class Board
  def initialize width = 3, height = 3
    @width = width
    @height = height
    @state = Array.new(@width) { Array.new(@height) }
  end

  def state
    @state
  end

  def place player, across, down
    raise 'Outside of the board' unless inside_board?(across, down)
    raise 'Space already taken' if @state[across][down]
    # line_filled? has an embarrassing failure mode if :all is on the board!
    raise 'Whoa. You used a reserved name :all' if player == :all
    @state[across][down] = player
  end

  def line_filled? player = :all
    # Check for a full line by any player if none is given
    return objects_on_board.any? { |player| line_filled? player } if player == :all
    # Check verticals
    return true if @state.transpose.any? { |row| row.uniq == [player] }
    # Check horizontals
    return true if @state.any? { |column| column.uniq == [player] }
    # Check diagonal from top left
    max_square_dimension = [@state.count, @state[0].count].max - 1
    top_left_diagonal = (0..max_square_dimension).collect{ |x_and_y| @state[x_and_y][x_and_y] }
    return true if top_left_diagonal.uniq == [player]
    # Check diagonal from top right
    top_right_diagonal = (0..max_square_dimension).collect{ |x_inv_y| @state[x_inv_y][max_square_dimension - x_inv_y]}
    return true if top_right_diagonal.uniq == [player]
    false
  end

  def full?
    @state.flatten.count(nil) == 0
  end

  private

  def inside_board? across, down
    return false if across < 0 || across >= @state.count
    return false if down < 0 || down >= @state[0].count
    true
  end

  def objects_on_board
    @state.flatten.compact.uniq
  end
end
