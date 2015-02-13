require_relative './Game.rb'

class ConsoleInterface
  
  def initialize
    @user_input = ''
    @game
  end
  
  def print_menu
    puts "Started Four-in-a-row game", "Menu:"
    puts "1.Start new Game",
         "2.Load game",
         "3.Quit",
         "Press 1,2 or 3"
  end

  def print_board board
    puts "#   1   2   3   4   5   6   7  "
    board.reverse.each_with_index do |row, index|
      puts "#{board.size - index}  |#{row.join("| |")}| "
    end
  end

  def initial_menu
    print_menu
    @user_input = gets
    case @user_input.to_i
      when 1 then start_new_game
      when 2 then load_game
      when 3 then quit
    end
  end

  def pre_game
    puts "Select who starts first:",
         "1.You",
         "2.Computer",
         "3.Random"
    player_to_start = gets.to_i
    if player_to_start == 3
      player_to_start = Random.rand(2) + 1
      puts "Random decided option #{player_to_start} to start."
    end
    player_to_start
  end

  def player_move_instruction
    puts "Select column to play(1...6)",
         "press 8 for game save",
         "press 9 for game restart",
         "press 0 for quit"
  end

  def start_new_game
  	player_to_start = pre_game
    @game = Game.new(player_to_start)
    loop_game
  end

  def read_user_input
    @user_input = gets.to_i
    case @user_input
      when 8 then @game.save_game
      when 9 then start_new_game
    end
  end

  def loop_game
    loop do
      print_board @game.get_board
      player_move_instruction
      read_user_input
      break if @user_input == 0
	  unless @game.user_move @user_input
	  	print_board @game.get_board
        puts "End of game"
	    break
	  end
    end
  end

  def load_game
  	saved_files = Game.load_game
  	saved_files.each_with_index do |save, index|
  	  puts "#{index}.#{save}" unless save == '.' or save == '..'
  	end
  	"Choose save file 0..#{saved_files.size - 2}:"
  	choice = gets.to_i
  	@game = Game.new
  	@game.load_game(saved_files, choice)
  	loop_game
  end

end

ConsoleInterface.new.initial_menu