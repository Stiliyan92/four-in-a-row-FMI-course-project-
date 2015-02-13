require_relative './Gameboard.rb'

class Game
  
  attr_reader :turn

  def initialize(turn = 1, max_depth = 4)
    @player = 'X'
    @computer = 'O'
    @current_board = GameBoard.new
    @max_depth = max_depth
    play_first_move(turn)
  end

  def play_first_move(turn)
    if(turn == 2)
      minimax(@current_board, @max_depth, -1.0/0.0, 1.0/0.0, @computer)
    end
  end

  def minimax(board, depth, alpha, beta, turn)
    other_player = turn == @player ? @computer : @player

    if board.end_of_game(other_player) or depth == 0
      return board.evaluate_board
    end

    possible_moves = board.generate_moves(turn)
    possible_moves.each do |move|
      sub_tree_score = minimax(move, depth - 1, alpha, beta, other_player)
      if turn == @computer
        if sub_tree_score > alpha
          alpha, board = sub_tree_score, move
        end
      else
        if sub_tree_score < beta
          beta, board = sub_tree_score, move
        end
      end
      break if beta < alpha
    end

    @current_board = board
	score = turn == @computer ? alpha : beta
  end

  def get_board
    @current_board.board
  end

  def user_move(input)
    @current_board.place_in_column(input - 1, @player)
     minimax(@current_board, @max_depth, -1.0/0.0, 1.0/0.0, @computer)
    if(@current_board.score > 60000 or @current_board.score < -60000)
      return nil
    else
      return get_board
    end
  end

  def save_game
  	print "Enter the name of the save file: "
  	file_name = gets.chomp
  	Dir.mkdir('./saved_games') unless File.directory? './saved_games'
  	File.open("./saved_games/#{file_name}", 'w') do |file_descriptor|
  	  saved_bytes = file_descriptor.write(Marshal.dump(@current_board))
  	  if saved_bytes > 0
        puts "Saved successfully!"
      else
        puts "Save error."
  	  end
  	end
  end

  def load_game(files, choice)
  	file_descriptor = File.open("./saved_games/#{files[choice]}")
  	@current_board = Marshal.load(file_descriptor)
  end

  def self.load_game
    saves = Dir.entries('./saved_games')
    saves
  end

end