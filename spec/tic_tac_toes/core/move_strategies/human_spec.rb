require 'tic_tac_toes/core/move_strategies/human'

describe TicTacToes::Core::MoveStrategies::Human do
  describe '#type' do
    it 'returns :human' do
      expect(TicTacToes::Core::MoveStrategies::Human.new('unused_io').type).to eq(:human)
    end
  end

  describe '#move' do
    let(:io)     { double('io', solicit_input: 0, move_solicitation: true, not_an_integer_error: true) }
    let(:human)  { TicTacToes::Core::MoveStrategies::Human.new(io) }

    it 'displays a move solicitation' do
      expect(io).to receive(:move_solicitation)
      human.move('game_state')
    end

    context 'when given not-integer-like input' do
      let(:not_integer_like)  { 'string' }
      let(:integer_like)      { '100' }

      it 'displays a not an integer error' do
        allow(io).to receive(:solicit_input).and_return(not_integer_like, integer_like)

        expect(io).to receive(:not_an_integer_error).once
        human.move('game_state')
      end

      it 'only returns a move (converted to integer) once it gets integer-like input' do
        allow(io).to receive(:solicit_input).and_return(not_integer_like, integer_like)

        expect(human.move('game_state')).to eq(100)
      end
    end
  end
end
