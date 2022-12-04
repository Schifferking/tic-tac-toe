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
end
