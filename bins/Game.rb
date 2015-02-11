require_relative './GameBoard'

class Game
  
  def initialize(player = 'X', computer = 'O')
 	@player = player
  	@computer = computer
  	@current_board = GameBoard.new
  end

  def minimax(board, depth, alpha, beta, turn)
  	other_player = turn == @player ? @computer : @player
    if(board.end_of_game(other_player) or depth == 0)
      return board.evaluate_score(other_player)
    end

    possible_moves = board.generate_moves(current_player, turn)
    possible_moves.each do |move|
      sub_tree_score = minimax(move, depth - 1, alpha, beta, other_player)
      if turn == @computer
      	if sub_tree_score > alpha
      	  alpha, @current_board = sub_tree_score, board
      	end
      else
      	if sub_tree_score < beta
      	  beta, @current_board = sub_tree_score, board
      	end
      end
      break if beta < alpha
    end

    @current_board = board
    score = turn == @computer ? alpha : beta
  end

