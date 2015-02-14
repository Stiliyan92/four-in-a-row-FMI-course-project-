require_relative './Game.rb'
require_relative './Colorize.rb'

class ConsoleInterface
  
  include Colorize

  def initialize
    @user_input = ''
    @game
  end

  def initial_menu
  	loop do		
      print_menu
      @user_input = gets
      case @user_input.to_i
        when 1 then start_new_game
        when 2 then load_game
        when 0 then break
      end
    end
  end

  def pre_game
    puts "Select who starts first:"
    puts green "1.You"
    puts red   "2.Computer"
    puts       "3.Random"

    player_to_start = gets.to_i
    if player_to_start == 3
      player_to_start = Random.rand(2) + 1
      puts "Random decided option #{player_to_start} to start."
    end
    player_to_start
  end

  def start_new_game
  	player_to_start = pre_game
    @game = Game.new(player_to_start)
    loop_game
  end

  def read_user_input
    @user_input = gets.to_i
    case @user_input
      when 8 then save
      when 9 then start_new_game
    end
  end

  def save
    print "Enter the name of the save file: "
  	file_name = gets.chomp
  	puts @game.save_game file_name
  end

  def end_game
    print_colored_board @game.get_board_array
    puts "End of game"
  end

  def loop_game
    loop do
      print_colored_board @game.get_board_array
      player_move_instruction
      read_user_input
      break if @user_input == 0

	  unless @game.user_move @user_input
	    puts "Choose correct column"
	    next
	  end
	  
	  if @game.check_if_player_wins
	  	end_game
	    break
	  end

	  if @game.computer_move
	  	end_game
	  	break
	  end

    end
  end

  def load_game
  	saved_files = Game.load_saved_games
  	if saved_files.size == 0
  	  puts "No saved games"
  	  return
  	end
  	saved_files.each_with_index do |save, index|
  	  puts "#{index}.#{save}"
  	end
  	"Choose save file 0..#{saved_files.size - 2}:"
  	choice = gets.to_i
  	@game = Game.new()
  	@game.load_game(saved_files[choice])
  	loop_game
  end

end

ConsoleInterface.new.initial_menu