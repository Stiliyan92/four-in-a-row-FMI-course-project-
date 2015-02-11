require_relative '../bins/Gameboard.rb'

describe GameBoard do
  before do
    @gameboard = GameBoard.new
    @gameboard.place_in_column(1,'X')
    @gameboard.place_in_column(2,'X')
    @gameboard.place_in_column(2,'O')
    @gameboard.place_in_column(2,'X')
    @gameboard.place_in_column(3,'O')
    @gameboard.place_in_column(3,'O')
    @gameboard.place_in_column(3,'O')
    @gameboard.place_in_column(3,'O')
    @gameboard.place_in_column(3,'X')
    @gameboard.place_in_column(3,'X')
  end

  it 'has board row array with proper size' do
    expect(@gameboard.board.size).to eq 6
  end

  it 'puts moves in proper column and row' do
    expect(@gameboard.board[1][2]).to eq 'O'
  end

  it 'puts moves in proper column and row' do
    expect(@gameboard.board[5][3]). to eq 'X'
  end

  it 'it gets 6 rows' do
  	expect(@gameboard.get_rows.size).to eq 6
  end

  it 'it gets 7 columns' do
  	expect(@gameboard.get_columns.size).to eq 7
  end

  it 'it gets 6 diagonals' do
  	expect(@gameboard.get_diagonals.size).to eq 6
  end

  it 'it gets 6 anti diagonals' do
  	expect(@gameboard.get_anti_diagonals.size).to eq 6
  end

  it 'return false for trying to put in full column' do
  	expect(@gameboard.place_in_column(3, 'X')).to eq false
  end

  it 'returns true if 4 in a row' do
  	expect(@gameboard.end_of_game('O')).to eq true
  end

  it 'creates proper string from anti diagonal' do
  	expect(@gameboard.get_anti_diagonal(0, 0)).to eq 'EEXOEE'
  end

end