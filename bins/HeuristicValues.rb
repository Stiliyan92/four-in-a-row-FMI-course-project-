class HeuristicValues

  def initialize 
  	@combos = {}
  	set_heuristic_values
  end

  def calculate_score(lines)
  	score = 0
  	lines.each do |line|
  	  score += get_line_score(line)
  	end
  	score
  end

  def set_heuristic_values
  	@combos[/XXXX/]            = 10000
  	@combos[/OXEEE/]           = 1
  	@combos[/OXXEE/]           = 10
  	@combos[/OXXXE/]           = 500
  	@combos[/EEEXO/]           = 1
  	@combos[/EEXXO/]           = 10 
 # 	@combos[/EXXXO/]          = 1000
 	@combos[/EXXX.*/]          = 500
  	@combos[/\AXEEE/]          = 1
  	@combos[/\AXXEE/]          = 10
  	@combos[/\AXXX[^OX]+/]     = 500
  	@combos[/EEEX\z/]          = 1
  	@combos[/EEXX\z/]          = 10
#  	@combos[/EXXX\z/]          = 1000
	@combos[/XXEX/]            = 500
	@combos[/XEXX/]            = 500
	@combos[/EXEXE/]           = 50
	@combos[/EXEX[^E]*/]       = 15
	@combos[/[^E]*XEXE/]       = 15
  	@combos[/E{1,3}XE{1,3}/]   = 20
  	@combos[/E{1,3}XXE{1,3}/]  = 100
  	@combos[/E{1,3}XXXE{1,3}/] = 5000
  	@combos[/.*/]               = 0
#    @combos[/[^O]XXX[^X]/]     = 80
#    @combos[/^XXX[^X]/]        = 100
  end

  def get_line_score(line)
    @combos.each do |key, value|
      return value if key =~ line
    end
  end

end

arr = []
arr << 'XXEEEE' << 'OXXOXEEE' << 'EOXXXEEE' << 'EEXXEEEE' << 'EXEEEE' << 'XEEEE' << 'EXEXOXEE'

my_hash = HeuristicValues.new
p my_hash.calculate_score(arr)
