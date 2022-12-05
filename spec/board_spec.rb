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
end
