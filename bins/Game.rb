require_relative './GameBoard'
class Game
  
  def initialize(player: 'X', computer: 'O')
# 	@player = player
#  	@computer = computer
  	@current_board = GameBoard.new(player, computer)
  end

  def minimax()
