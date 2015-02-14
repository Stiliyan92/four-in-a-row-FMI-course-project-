module GameBoardGetMethods

  
  @@connect = 4
  @@height = 6
  @@width = 7

  private
  def get_rows
    row_lines = []
    @board.each do |row|
      row_lines << row.join
    end
    row_lines
  end

  #maybe can be edited using some Array method
  def get_columns
    column_lines = []
    0.upto(@@width - 1) do |column|
      column_line = ""
      0.upto(@@height - 1) do |row|
        column_line << @board[row][column]
      end
      column_lines << column_line
    end
    column_lines
  end

  def get_anti_diagonals
    diagonal_lines = []
    
    0.upto(@@width - @@connect) do |column|
      diagonal_line = get_anti_diagonal(0, column)
      diagonal_lines << diagonal_line
    end

    1.upto(@@height - @@connect) do |row|
      diagonal_line = get_anti_diagonal(row, 0)
      diagonal_lines << diagonal_line
    end
    diagonal_lines
  end

  def get_anti_diagonal(start_row, start_column)
    row, column, line = start_row, start_column, "" 
    while row < @@height and column < @@width
      line << @board[row][column]
      row += 1
      column += 1
    end
    line
  end

  def get_diagonals
    diagonal_lines = []

    (@@width - 1).downto(@@connect - 1) do |column|
      diagonal_line = get_diagonal(0, column)
      diagonal_lines << diagonal_line
    end

    1.upto(@@height - @@connect) do |row|
      diagonal_line = get_diagonal(row, @@width - 1)
      diagonal_lines << diagonal_line
    end
    diagonal_lines
  end

  def get_diagonal(start_row, end_column)
    row, column, line = start_row, end_column, ""
    while row < @@height and column >= 0
      line << @board[row][column]
      row += 1
      column -= 1
    end
    line
  end

end