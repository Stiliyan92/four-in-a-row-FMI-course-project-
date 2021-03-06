require_relative '../bins/Gameboard.rb'

describe GameBoard do
  before do
    @gameboard = GameBoard.new
    @gameboard.place_in_column(0, 'X')
    @gameboard.place_in_column(0, 'O')
    @gameboard.place_in_column(1, 'X')
    @gameboard.place_in_column(1, 'X')
    @gameboard.place_in_column(2, 'X')
    @gameboard.place_in_column(2, 'O')
    @gameboard.place_in_column(2, 'X')
    @gameboard.place_in_column(3, 'O')
    @gameboard.place_in_column(3, 'O')
    @gameboard.place_in_column(3, 'O')
    @gameboard.place_in_column(4, 'O')
    @gameboard.place_in_column(4, 'X')
    @gameboard.place_in_column(5, 'X')
    @gameboard.place_in_column(5, 'X')
    @gameboard.place_in_column(6, 'O')
    @gameboard.place_in_column(6, 'O')
  end

  it 'has board row array with proper size' do
    expect(@gameboard.board.size).to eq 6
  end

  it 'gets 6 rows from #get_rows' do
    expect((@gameboard.send :get_rows).size).to eq 6
  end

  it 'creates proper string from third row' do
    expect((@gameboard.send :get_rows)[2]).to eq 'EEXOEEE'
  end

  it 'creates proper string from second row' do
    expect((@gameboard.send :get_rows)[1]).to eq 'OXOOXXO'
  end

  it 'gets 7 columns from #get_columns' do
    expect((@gameboard. send :get_columns).size).to eq 7
  end

  it 'creates proper string from third column' do
    expect((@gameboard.send :get_columns)[2]).to eq 'XOXEEE'
  end

  it 'creates proper string from fourth column' do
    expect((@gameboard.send :get_columns)[3]).to eq 'OOOEEE'
  end

  it 'gets 6 diagonals from #get_diagonals' do
    expect((@gameboard.send :get_diagonals).size).to eq 6
  end

  it 'gets 6 anti diagonals from #get_anti_diagonals' do
    expect((@gameboard.send :get_anti_diagonals).size).to eq 6
  end

  it 'creates proper string from #get_anti_diagonal' do
    expect(@gameboard.send :get_anti_diagonal, 0, 0).to eq 'XXXEEE'
  end

  it 'creates proper string from #get_anti_diagonal' do
    expect(@gameboard.send :get_anti_diagonal, 1, 0).to eq 'OEEEE'
  end

  it 'creates proper string from #get_diagonal' do
    expect(@gameboard.send :get_diagonal, 0, 3).to eq 'OOEE'
  end

  it 'creates proper string from #get_diagonal' do
    expect(@gameboard.send :get_diagonal, 1,6).to eq 'OEEEE'
  end

  it 'puts moves in proper column and row' do
    expect(@gameboard.board[1][2]).to eq 'O'
  end

  it 'returns true for trying to #place_in_column in not full column' do
    expect(@gameboard.place_in_column(2,'X')).to eq true
  end

  it 'score should be 0' do
  	expect(@gameboard.score).to eq 16
  end

  context 'gameboard has a winning column' do
    before do
      @gameboard.place_in_column(3, 'O')
      @gameboard.place_in_column(3, 'X')
      @gameboard.place_in_column(3, 'X')
    end
    
    it 'puts moves in proper column and row' do
      expect(@gameboard.board[5][3]). to eq 'X'
    end

    it 'returns false for trying to #place_in_column in full column' do
      expect(@gameboard.place_in_column(3, 'X')).to eq false
    end

    it 'returns true for #end_of_game if 4 in a column' do
      expect(@gameboard.end_of_game('O')).to eq true
    end

    it 'creates proper string from #get_anti_diagonal' do
      expect(@gameboard.send :get_anti_diagonal, 1, 0).to eq 'OEEXE'
    end

    it 'creates proper string from #get_diagonal' do
      expect(@gameboard.send :get_diagonal, 1, 6).to eq 'OEEXE'
    end

    it '#generate_moves returns array with 6 elements for board with full column' do
      expect(@gameboard.generate_moves('X').size).to eq 6
    end

  end


  context 'gameboard has a winning row' do
    before do
      @gameboard.place_in_column(4, 'O')
      @gameboard.place_in_column(5, 'O')
    end

    it 'returns false for #end_of_game with only 3 in a row' do
      expect(@gameboard.end_of_game('O')).to eq false
    end

    it 'returns true for #end_of_game with 4 in a row' do
      @gameboard.place_in_column(6, 'O')
      expect(@gameboard.end_of_game('O')).to eq true
    end

  end


  context 'gameboard has a winning diagonal' do
    before do
      @gameboard.place_in_column(3,'X')
    end

   it 'returns true for #end_of_game with 4 X in a diagonal' do
     expect(@gameboard.end_of_game('X')).to eq true
   end
  end


  context 'gameboard has a winning anti diagonal' do
    before do
      @gameboard.place_in_column(5, 'O')
      @gameboard.place_in_column(4, 'O')
      @gameboard.place_in_column(4, 'O')
      @gameboard.place_in_column(3, 'X')
    end

    it 'returns false for #end_of_game without a winning anti diagonal' do
      expect(@gameboard.end_of_game('O')).to eq false
    end

    it 'returns true for #end_of_game with a winning anti diagonal' do
      @gameboard.place_in_column(3, 'O')
      expect(@gameboard.end_of_game('O')).to eq true
    end

  end

  it 'evaluates board with proper score' do
    expect(@gameboard.evaluate_board).to eq 16
  end

  it 'sets proper score' do
  	expect(@gameboard.score).to eq 16
  end

  it 'generates moves properly - returns proper sized Array' do
    expect(@gameboard.generate_moves('X').size).to eq 7
  end

  it 'deep clones current object' do
    cloned = @gameboard.clone
    cloned.place_in_column(0,'S')
    expect(@gameboard.board[2][0]).not_to eq cloned.board[2][0]
  end

end