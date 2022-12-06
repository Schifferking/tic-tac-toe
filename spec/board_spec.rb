require_relative '../lib/board'

describe Board do
  describe '#fill_cell' do
    context 'when filling a cell' do
      subject(:board_cell_fill) { described_class.new }

      it "changes a cell's value" do
        row = 1
        column = 1
        mark = 'X'
        expect { board_cell_fill.fill_cell(row, column, mark) }
          .to change {board_cell_fill.board[1][1]}.from(nil).to('X')
      end
    end
  end

  describe '#cell_filled?' do
    context 'when a cell has no value' do
      subject(:board_cell_empty) { described_class.new }

      it 'returns false' do
        row = 2
        column = 1
        expect(board_cell_empty.cell_filled?(row, column)).to be false
      end
    end

    context 'when a cell has a value' do
      subject(:board_cell_value) { described_class.new }

      before do
        row = 2
        column = 0
        mark = 'X'
        board_cell_value.board[row][column] = mark
      end

      it 'returns true' do
        row = 2
        column = 0
        expect(board_cell_value.cell_filled?(row, column)).to be true
      end
    end
  end

  describe '#board_full?' do
    context 'when the board at least has an empty cell' do
      subject(:board_not_full) { described_class.new }

      before do
        x_mark = 'X'
        o_mark = 'O'
        # Fill cells
        board_not_full.board[0][0] = x_mark
        board_not_full.board[0][1] = o_mark
        board_not_full.board[0][2] = o_mark

        board_not_full.board[1][0] = x_mark
        board_not_full.board[1][1] = x_mark
        board_not_full.board[1][2] = o_mark

        board_not_full.board[2][0] = o_mark
        board_not_full.board[2][1] = x_mark
      end

      it 'returns false' do
        expect(board_not_full).not_to be_board_full
      end
    end

    context 'when the board is full' do
      subject(:board_already_full) { described_class.new }

      before do
        x_mark = 'X'
        o_mark = 'O'
        # Fill board
        board_already_full.board[0][0] = x_mark
        board_already_full.board[0][1] = o_mark
        board_already_full.board[0][2] = o_mark

        board_already_full.board[1][0] = o_mark
        board_already_full.board[1][1] = o_mark
        board_already_full.board[1][2] = x_mark

        board_already_full.board[2][0] = x_mark
        board_already_full.board[2][1] = x_mark
        board_already_full.board[2][2] = o_mark
      end

      it 'returns true' do
        expect(board_already_full).to be_board_full
      end
    end
  end

  describe '#obtain_row_values' do
    context 'when the row parameter is equal to 0' do
      subject(:board_row_zero) { described_class.new }

      it "returns a list with the row's values" do
        row = 0
        expected = [nil, nil, nil]
        expect(board_row_zero.obtain_row_values(row)).to eq expected
      end
    end

    context 'when the row parameter is equal to 2' do
      subject(:board_row_two) { described_class.new }

      before do
        x_mark = 'X'
        row = 2
        board_row_two.board[row][0] = x_mark
        board_row_two.board[row][1] = x_mark
        board_row_two.board[row][2] = x_mark
      end

      it "returns a list with the row's values" do
        row = 2
        x_mark = 'X'
        expected = [x_mark, x_mark, x_mark]
        expect(board_row_two.obtain_row_values(row)).to eq expected
      end
    end
  end

  describe '#obtain_cell_value' do
    context 'when row is 0 and column is 0' do
      subject(:board_cell_zero_zero) { described_class.new }

      it "returns the cell's value" do
        row = 0
        column = 0
        expect(board_cell_zero_zero.obtain_cell_value(row, column)).to eq nil
      end
    end

    context 'when row is 1 and column is 2' do
      subject(:board_cell_one_two) { described_class.new }

      before do
        o_mark = 'O'
        row = 1
        column = 2
        board_cell_one_two.board[row][column] = o_mark
      end

      it "returns the cell's value" do
        row = 1
        column = 2
        expected = 'O'
        expect(board_cell_one_two.obtain_cell_value(row, column)).to eq expected
      end
    end
  end

  describe '#obtain_column_values' do
    subject(:board_column_test) { described_class.new }

    it 'calls #obtain_cell_value three times' do
      column = 1
      expect(board_column_test).to receive(:obtain_cell_value).exactly(3).times
      board_column_test.obtain_column_values(column)
    end

    context 'when the column is 2' do
      subject(:board_column_two) { described_class.new }

      before do
        column = 2
        x_mark = 'X'
        board_column_two.board[1][column] = x_mark
      end

      it 'returns a list with the column values' do
        x_mark = 'X'
        column = 2
        expected = [nil, x_mark, nil]
        expect(board_column_two.obtain_column_values(column)).to eq expected
      end
    end
  end

  describe '#obtain_left_diagonal' do
    subject(:board_left_diagonal) { described_class.new }

    it 'calls #obtain_cell_value three times' do
      expect(board_left_diagonal)
        .to receive(:obtain_cell_value).exactly(3).times
      board_left_diagonal.obtain_left_diagonal
    end

    it 'returns a list with 3 elements' do
      result = board_left_diagonal.obtain_left_diagonal
      expect(result.length).to eq 3
    end
  end
end
