require_relative './HeuristicValues.rb'
require_relative './GameBoardGetMethods.rb'

class GameBoard

  include GameBoardGetMethods

  @@heuristic_values = HeuristicValues.new

  attr_accessor :board, :score
#  attr_writer :board

  def initialize(to_play_first = 'X')
    @none = 'E'
    @board = Array.new(6) { Array.new(7, @none) }
    @score = 0
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
  end

  def get_field(row, column)
    @board[row][column]
  end

  def place_in_column(column, player)
    return false if @board[@@height - 1][column] != @none

    0.upto(5) do |row|
      if @board[row][column] == @none
        @board[row][column] = player
        evaluate_board
        return true
      end
    end
  end

  def evaluate_board
    score_player, score_ai = 0, 0
    get_line_methods = %w(rows columns diagonals anti_diagonals)
    get_line_methods.each do |method|
      lines = self.send "get_#{method}"
      score_player += @@heuristic_values.calculate_score(lines, 'X')
      score_ai += @@heuristic_values.calculate_score(lines, 'O')
    end
    @score = score_ai - score_player
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

  private
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

end

