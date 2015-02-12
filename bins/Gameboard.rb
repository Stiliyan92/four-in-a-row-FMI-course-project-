require_relative './HeuristicValues.rb'

module GameBoardGetMethods

  @@connect = 4
  @@height = 6
  @@width = 7

  def get_rows
    row_lines = []
    @board.each do |row|
      row_lines << row.join
    end
    row_lines
  end

  #maybe can be edited using some Array method
  def get_columns
    column_lines = []
    0.upto(@@width - 1) do |column|
      column_line = ""
      0.upto(@@height - 1) do |row|
        column_line << @board[row][column]
      end
      column_lines << column_line
    end
    column_lines
  end

 def get_anti_diagonals
    diagonal_lines = []
    
    0.upto(@@width - @@connect) do |column|
      diagonal_line = get_anti_diagonal(0, column)
      diagonal_lines << diagonal_line
    end

    1.upto(@@height - @@connect) do |row|
      diagonal_line = get_anti_diagonal(row, 0)
      diagonal_lines << diagonal_line
    end
    diagonal_lines
  end

  def get_anti_diagonal(start_row, start_column)
    row, column, line = start_row, start_column, "" 
    while row < @@height and column < @@width
      line << @board[row][column]
      row += 1
      column += 1
    end
    line
  end

  def get_diagonals
    diagonal_lines = []

    (@@width - 1).downto(@@connect - 1) do |column|
      diagonal_line = get_diagonal(0, column)
      diagonal_lines << diagonal_line
    end

    1.upto(@@height - @@connect) do |row|
      diagonal_line = get_diagonal(row, @@width - 1)
      diagonal_lines << diagonal_line
    end
    diagonal_lines
  end

  def get_diagonal(start_row, end_column)
    row, column, line = start_row, end_column, ""
    while row < @@height and column >= 0
      line << @board[row][column]
      row += 1
      column -= 1
    end
    line
  end

end

class GameBoard

  include GameBoardGetMethods

  @@heuristic_values = HeuristicValues.new

  attr_accessor :turn, :board
#  attr_writer :board

  def initialize(to_play_first = 'X')
    @none = 'E'
    @board = Array.new(6) { Array.new(7, @none) }
    @turn = to_play_first
 #   @empty_fields = 42
  end

  def dup_recursive(old_array)
    new_array = []
    old_array.each do |item|
      if item.class == Array
        new_array << dup_recursive(item)
      else
        new_item = item.dup rescue new_item = item # in case it's got no dupe, like FixedNum
        new_array << new_item
      end
    end
    new_array
  end
  
   #used for generating moves from current board
  def initialize_copy(other)
    super
    self.board = []
    self.board = dup_recursive(other.board)
  end

  def set_field(row, column, player)
    r = row - 1
    c = column - 1
    @board[r][c] = player unless @board[r][c] != @none
#   @empty_fields = empty_fields - 1
  end

  def get_field(row, column)
    @board[row][column]
  end

  def place_in_column(column, player)
    return false if @board[@@height - 1][column] != @none

    0.upto(5) do |row|
      if @board[row][column] == @none
        @board[row][column] = player
#        @empty_fields = @empty_fields - 1
        return true
      end
    end
  end

  def evaluate_board
    score_player, score_ai = 0, 0
    get_line_methods = %w(rows columns diagonals anti_diagonals)
    get_line_methods.each do |method|
      lines = self.send "get_#{method}"
      score_player += @@heuristic_values.calculate_score(lines, 'O')
      score_ai += @@heuristic_values.calculate_score(lines, 'X')
    end
    score = score_ai - score_player
  end

  def end_of_game(last_played)
    get_line_methods = %w(rows columns diagonals anti_diagonals)
    get_line_methods.each do |method|
      lines = self.send "get_#{method}"
      if check_lines(lines, last_played)
        return true
      end
    end
    return false
  end
    
  def check_lines(lines, last_played)
    lines.each do |line|
      if @@heuristic_values.get_line_score(line, last_played) > 10000
        return true
      end
    end
    return false
  end

  def generate_moves(turn)
    played_next_moves = []
    0.upto(6) do |col|
      next_move = self.clone
      played_next_moves << next_move if next_move.place_in_column(col, turn)
    end
    played_next_moves
  end

  def print_board
    p "#   1   2   3   4   5   6   7  "
    @board.reverse.each_with_index do |row, index|
      p "#{@board.size - index}  |#{row.join("| |")}| "
    end
  end
end

  #used for generating moves from current board
#  def clone
#    new_board = GameBoard.new(@player, @computer, @turn)
#    new_board.board = []
#    dup_recursive(new_board.board, @board)
#    new_board.empty_fields = @empty_fields
#    new_board
#  end
