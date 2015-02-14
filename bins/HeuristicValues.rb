class HeuristicValues

  def initialize 
    @combos_x = {}
    @combos_o = {}
    set_heuristic_values_x
    set_heuristic_values_o
  end

  def calculate_score(lines, last_played)
    score = 0
    lines.each do |line|
      score += get_line_score(line, last_played)
    end
    score
  end

  def get_line_score(line, last_played)
    combos = last_played == 'X' ? @combos_x : @combos_o
    combos.each do |key, value|
      return value if key =~ line
    end
  end

  private
  #setting heuristic values.Next turn is 'x'
  def set_heuristic_values_o
    @combos_o[/OOOO/]            = 100000
    @combos_o[/E{1,3}OOOE{1,3}/] = 1000
    @combos_o[/XOOOE/]           = 500
    @combos_o[/OOEO/]            = 500
    @combos_o[/OEOO/]            = 500
    @combos_o[/\AOOO[E]+/]       = 500
    @combos_o[/EOOOX/]           = 500
    @combos_o[/EOOO\z/]          = 500
    @combos_o[/E{1,3}OOE{1,3}/]  = 100
    @combos_o[/EOEOE/]           = 30
    @combos_o[/E{1,3}OE{1,3}/]   = 10
    @combos_o[/EOEO[^E]*/]       = 10
    @combos_o[/[^E]*OEOE/]       = 10
    @combos_o[/XOOEE/]           = 10
    @combos_o[/XOEEE/]           = 2
    @combos_o[/EEOOX/]           = 10 
    @combos_o[/EEEOX/]           = 2
    @combos_o[/\AOOEE/]          = 10
    @combos_o[/\AOEEE/]          = 2
    @combos_o[/EEOO\z/]          = 10
    @combos_o[/EEEO\z/]          = 2
    @combos_o[/.*/]              = 0
#    @combos_o[/[^X]OOO[^O]/]     = 80
#    @combos_o[/^OOO[^O]/]        = 100
  end

    #next turn is 'x'
  def set_heuristic_values_x
    @combos_x[/XXXX/]            = 100000
    @combos_x[/E{1,3}XXXE{1,3}/] = 1000
    @combos_x[/OXXXE/]           = 500
    @combos_x[/XXEX/]            = 500
    @combos_x[/XEXX/]            = 500
#   @combos_x[/EXXX[OE]+/]       = 500
    @combos_x[/EXXXO/]           = 500
    @combos_x[/\AXXX[E]+/]       = 500
    @combos_x[/EXXX\z/]          = 500
    @combos_x[/E{1,3}XXE{1,3}/]  = 100
    @combos_x[/EXEXE/]           = 50
    @combos_x[/E{1,3}XE{1,3}/]   = 15
    @combos_x[/EXEX[^E]*/]       = 15
    @combos_x[/[^E]*XEXE/]       = 15
    @combos_x[/OXXEE/]           = 10
    @combos_x[/OXEEE/]           = 2
    @combos_x[/EEXXO/]           = 10
    @combos_x[/EEEXO/]           = 2
    @combos_x[/\AXXEE/]          = 10
    @combos_x[/\AXEEE/]          = 2
    @combos_x[/EEXX\z/]          = 10
    @combos_x[/EEEX\z/]          = 2
    @combos_x[/.*/]               = 0
#    @combos_x[/[^O]XXX[^X]/]     = 80
#    @combos_x[/^XXX[^X]/]        = 100
  end

end