require "gosu"
require_relative "./Game.rb"

class GameWindow < Gosu::Window
  
  attr_accessor :width, :cell_width, :position
  
  def initialize
    @height = 630
    @cell_width = 90
    super(@height, @height, false)
    @game = Game.new
    @board = []
    @player_won, @computer_won= false, false
    @field_font = Gosu::Font.new(self, Gosu::default_font_name, cell_width)
    @message_font = Gosu::Font.new(self, Gosu::default_font_name, 22)
    @save_file_name = "gui_save"
  end
  
  def button_down(id)
    case id
      when Gosu::KbEscape   then close
      when Gosu::KbF1       then save_game
      when Gosu::KbF2       then load_game
      when Gosu::KbF3       then restart_game
      when Gosu::MsLeft     then play_move 
    end
  end
  
  def needs_cursor?
    true
  end
  
  def save_game
    @game.save_game @save_file_name
  end

  def check_for_saved_games(loaded_files)
  	saves_count = loaded_files.size
    if saves_count == 0
      return false
    elsif loaded_files.include? '@save_file_name'
      return true
    end
  end

  def load_game
  	loaded_files = Game.load_saved_games
  	unless check_for_saved_games loaded_files
      return
    end
    @game.load_game @save_file_name
  end

  def restart_game
    @game = Game.new
  end

  def play_move
  	loop do
  	  column = (mouse_x / cell_width + 1).to_i
      if @game.user_move(column)
      	if @game.check_if_player_wins
          @player_won = true
        elsif @game.computer_move
          @computer_won = true
        end
        break
      end
    end
  end

  def draw
    # draw grid
    0.upto(6) do |i|
      draw_line(i * @cell_width, @cell_width, Gosu::Color::WHITE, i * cell_width, @height, Gosu::Color::WHITE)
      draw_line(0, i * cell_width, Gosu::Color::WHITE, @height, i * cell_width, Gosu::Color::WHITE)
    end

    @message_font.draw("Press F1 to save game.", 0, 0, 0)
    @message_font.draw("Press F2 to load game.", 0, 22, 0)
    @message_font.draw("Press F3 to restart game.", 0, 44, 0)
    @message_font.draw("Press Esc to quit game.", 0, 66, 0)
  
  # draw position
    unless @computer_won or @player_won
      @game.get_board.each_with_index do |row, i|
        row.each_with_index do |elem, j|
          if elem != 'E'
            x_coord = j * cell_width + @field_font.text_width(elem)/2.5
            y_coord = (6 - i) * cell_width + @field_font.text_width(elem)/4
            @field_font.draw(elem, x_coord, y_coord, 0)
          end
        end
      end
    end
    display_message("You won") if @player_won
    display_message("Computer won") if @computer_won

  end

  def display_message(text)
    black = Gosu::Color::BLACK
    draw_quad(100,250,black,
              @height - 100, 200, black,
              @height - 100, 450, black,
              100, 450, black)
    @message_font.draw(text, (@height - @message_font.text_width(text))/2, @height/2 - 100, 0)
   end
end

game = GameWindow.new
game.show