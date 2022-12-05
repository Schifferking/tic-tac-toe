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
end
