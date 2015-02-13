module Colorize

  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end
  
  def red(text) 
    colorize(text, 31)
  end
  
  def green(text)
  	colorize(text, 32)
  end

  def yellow(text)
    colorize(text, 33)
  end

  def gray(text)
    colorize(text, 37)
  end

  def black(text)
    colorize(text, 35)
  end

  def blue(text)
    colorize(text, 34)
  end

  def cyan(text)
    colorize(text, 36)
  end

  def magenta(text)
    colorize(text, 35)
  end

  def print_colored_row(list_of_strings)
    print " "
    list_of_strings.each do |symbol|
      print " |"
      print print_symbol(symbol)
      print "|"
    end
    puts
  end

  def print_symbol(symbol)
    ansi_code = case symbol
                  when 'X' then "\e[#{32}m#{symbol}\e[0m"
                  when 'O' then "\e[#{31}m#{symbol}\e[0m"
                  when 'E' then "\e[#{37}m#{symbol}\e[0m"
                end
    ansi_code
  end

  def print_white_board board
    puts "#   1   2   3   4   5   6   7  "
    board.reverse.each_with_index do |row, index|
      puts "#{board.size - index}  |#{row.join("| |")}| "
    end
  end

  def print_colored_board board
    puts yellow "#   1   2   3   4   5   6   7  "
    board.reverse.each_with_index do |row, index|
      print yellow "#{board.size - index}"
      print_colored_row row
    end
  end

  def print_menu
    puts blue("\n\nStarted Four-in-a-row game\n")
    puts magenta "Menu:"
    puts  "1.Start new Game",
          "2.Load game",
          "3.Quit",
          "Press 1,2 or 3"
  end

end
