# frozen_string_literal: true

require_relative '../lib/tic_tac_toe'
require_relative '../lib/player'
require_relative '../lib/board'

describe TicTacToe do
  describe '#number?' do
    context 'when the input is not a number' do
      subject(:tictactoe_not_number) { described_class.new }

      it 'returns false' do
        input = 'zero'
        expect(tictactoe_not_number.number?(input)).to be false
      end
    end

    context 'when the input is a number' do
      subject(:tictactoe_number) { described_class.new }

      it 'returns true' do
        input = '5'
        expect(tictactoe_number.number?(input)).to be true
      end
    end
  end
end
