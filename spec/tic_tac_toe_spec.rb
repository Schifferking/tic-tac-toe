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

  describe '#validate_number' do
    context 'when the number is lesser than 1' do
      subject(:tic_tac_toe_below_one) { described_class.new }

      it 'returns nil' do
        number = 0
        expect(tic_tac_toe_below_one.validate_number(number)).to be nil
      end
    end

    context 'when the number is greater than 9' do
      subject(:tic_tac_toe_above_nine) { described_class.new }

      it 'returns nil' do
        number = 10
        expect(tic_tac_toe_above_nine.validate_number(number)).to be nil
      end
    end

    context 'when the number is between 1 and 9' do
      subject(:tic_tac_toe_valid_number) { described_class.new }

      it 'returns the number' do
        number = 7
        expect(tic_tac_toe_valid_number.validate_number(number)).to eq number
      end
    end
  end
end
