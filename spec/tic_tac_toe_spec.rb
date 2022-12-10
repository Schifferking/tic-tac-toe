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

      it 'returns false' do
        number = 0
        expect(tic_tac_toe_below_one.validate_number(number)).to be false
      end
    end

    context 'when the number is greater than 9' do
      subject(:tic_tac_toe_above_nine) { described_class.new }

      it 'returns false' do
        number = 10
        expect(tic_tac_toe_above_nine.validate_number(number)).to be false
      end
    end

    context 'when the cell is not filled' do
      subject(:tic_tac_toe_number_invalid) { described_class.new }

      it 'returns false' do
        number = 9
        expect(tic_tac_toe_number_invalid.validate_number(number)).to be false
      end
    end

    context 'when the cell is filled' do
      subject(:tic_tac_toe_number_valid) { described_class.new }

      before do
        row = 1
        column = 1
        number = 5
        allow(tic_tac_toe_number_valid)
          .to receive(:number?).with(number).and_return(true)
        allow(tic_tac_toe_number_valid)
          .to receive(:number_in_range?).with(number).and_return(true)
        allow(tic_tac_toe_number_valid)
          .to receive(:cell_filled?).with(row, column).and_return(false)
      end

      it 'returns true' do
        number = 5
        expect(tic_tac_toe_number_valid.validate_number(number)).to be true
      end
    end
  end

  describe '#obtain_cell_value' do
    subject(:tic_tac_toe_cell_value) { described_class.new }

    it 'returns a value given the parameters' do
      row = 1
      column = 2
      expect(tic_tac_toe_cell_value.obtain_cell_value(row, column)).to be nil
    end
  end

  describe '#fill_cell' do
    subject(:tic_tac_toe_fill_cell) { described_class.new }

    it 'returns the mark parameter' do
      row = 0
      column = 0
      mark = 'O'
      expect(tic_tac_toe_fill_cell.fill_cell(row, column, mark)).to eq mark
    end
  end

  describe '#obtain_valid_coordinates' do
    context 'when the player entered a valid input' do
      subject(:tic_tac_toe_one_iteration) { described_class.new }

      before do
        number = '3'
        allow(tic_tac_toe_one_iteration)
          .to receive(:obtain_current_player_input).and_return(number)
      end

      it 'prints the prompt message once and ends the loop' do
        player = instance_double('player', mark: 'O')
        expect(tic_tac_toe_one_iteration)
          .to receive(:print_prompt_message).once
        tic_tac_toe_one_iteration.obtain_valid_coordinates(player)
      end
    end

    context 'when the player entered an invalid input and a valid input' do
      subject(:tic_tac_toe_two_iterations) { described_class.new }

      before do
        number_word = 'one'
        number = '1'
        allow(tic_tac_toe_two_iterations)
          .to receive(:obtain_current_player_input)
          .and_return(number_word, number)
      end

      it 'prints the prompt message twice and ends the loop' do
        player = instance_double('player', mark: 'x')
        expect(tic_tac_toe_two_iterations)
          .to receive(:print_prompt_message).twice
        tic_tac_toe_two_iterations.obtain_valid_coordinates(player)
      end
    end
  end
end
