require_relative '../bins/Game.rb'

describe Game do
  before do
  	@game = Game.new
  end

  it 'should initialize empty board' do
    expect(@game.get_board_array).to eq GameBoard.new.board
  end
  
  context 'play moves, save game, load' do
    before do
      board = GameBoard.new
      @computer = 'O'
      @player = 'X'
      board.place_in_column(0, @computer)
      board.place_in_column(1, @player)
      board.place_in_column(1, @player)
      board.place_in_column(2, @player)
      board.place_in_column(1, @computer)
      board.place_in_column(2, @player)
      board.place_in_column(3, @computer)
      board.place_in_column(3, @computer)
      board.place_in_column(3, @computer)
      board.place_in_column(4, @computer)
      board.place_in_column(4, @player)
      board.place_in_column(5, @player)
      board.place_in_column(5, @player)
      board.place_in_column(6, @computer)
      board.place_in_column(6, @computer)
      @game = Game.new(1, board)
    end
  
    it 'plays user move in proper column' do
      @game.user_move(4)
  	  expect(@game.get_board_array[3][3]).to eq 'X'
    end

    it 'checks correctly if player wins' do
      expect(@game.check_if_player_wins).to eq false
    end

    it 'checks correctly if player wins with winning column' do
      @game.user_move(6)
      @game.user_move(6)
      expect(@game.check_if_player_wins).to eq true
    end
    
    it 'saves game and returns proper string' do
      expect(@game.save_game "test").to eq "Saved successfully!"
    end

    it 'saves game file correctly' do
      @game.save_game 'test'
      expect(File.file?('../bins/saved_games/test')).to eq true
    end
    
    it 'loads test file correctly' do
      to_load_game = Game.new
      to_load_game.load_game "test"
      expect(@game.get_board_array).to eq to_load_game.get_board_array
    end

    it 'returns array with test file' do
      @game.save_game 'test'
      expect(Game.load_saved_games.include?('test')).to eq true
    end

    it 'returns array without test file' do
      File.delete('../bins/saved_games/test')
      expect(Game.load_saved_games.include?('test')).to eq false
    end

  end
  
  context 'computer place first' do
    before do
      @second_turn = Game.new(2)
      @board = @second_turn.get_board_array.flatten
    end

    it 'should play first move' do
  	  expect(@board.include?('O')).to eq true
    end

    it "should not have player's fields" do
      expect(@board.include?('X')).to eq false
    end

  end

end