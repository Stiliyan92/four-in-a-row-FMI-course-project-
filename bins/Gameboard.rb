require_relative './HeuristicValues.rb'

class GameBoard
  
  attr_accessor :turn, :board
#  attr_writer :board

  def initialize(player_sign =  'X' , computer_sign = 'O', to_play_first = 'X')
    @none = 'E'
    @player = player_sign
    @computer = computer_sign
    @board = Array.new(6) { Array.new(7, @none) }
    @turn = to_play_first
 #   @empty_fields = 42
  end

  #used for generating moves from current board
  def clone
    new_board = GameBoard.new(@player, @computer, @turn)
    new_board.board = @board.clone
#    new_board.empty_fields = @empty_fields
    new_board
  end

  def get_anti_diagonals
    array_of_diagonals = ["", "", "", ""]
    diagonal1 = ""
    diagonal2 = ""
    @board.each_with_index do |row, index|
      diagonal1 += row[index]
      diagonal2 += row[index + 1]
    end
    array_of_diagonals << diagonal1 << diagonal2
  end

  def set_field(row, column, player)
    r = row - 1
    c = column - 1
    @board[r][c] = player unless @board[r][c] != @none
#    @empty_fields = empty_fields - 1
  end

  def get_field(row, column)
    @board[row][column]
  end

  def place_in_column(column, player)
    return false if @board[5][column] != @none

    0.upto(5) do |row|
      if @board[row][column] == @none
        @board[row][column] = player
#        @empty_fields = @empty_fields - 1
        return true
      end
    end
  end

  def generate_moves(turn)
    played_next_moves = []
    0.upto(6) do |col|
      next_move = self.clone
      next_move.place_in_column(col, turn)
      played_next_moves << next_move
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

my_game = GameBoard.new
#my_game.print_elements
my_game.set_field(2,2, 'O')
my_game.set_field(3,3, 'X')
my_game.set_field(2,3, 'X')
my_game.set_field(5,1, "F")

my_game.print_board

p my_game.place_in_column(2,'O')
p my_game.place_in_column(2,'O')
p my_game.place_in_column(2,'O')
p my_game.place_in_column(2,'O')
p my_game.place_in_column(2,'O')

my_game.print_board

arr = []
arr << 'XXEEEE' << 'OXXOXEEE' << 'EOXXXEEE' << 'EEXXEEEE' << 'EXEEEE' << 'XEEEE' << 'EXEXOXEE'

my_hash = HeuristicValues.new
p my_hash.calculate_score(my_game.get_anti_diagonals)

my_game.generate_moves('W').each do |game|
  game.print_board
end

my_game.print_board