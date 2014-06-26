require 'tic_tac_toes/move_strategies/human'

describe TicTacToes::MoveStrategies::Human do
  describe '#move' do
    let(:io)     { double("io", solicit_input: 0, move_solicitation: true, not_an_integer_error: true) }
    let(:human)  { TicTacToes::MoveStrategies::Human.new(io) }

    it "displays a move solicitation" do
      expect(io).to receive(:move_solicitation)
      human.move("board", "players")
    end

    context 'when given not-integer-like input' do
      let(:not_integer_like)  { "string" }
      let(:integer_like)      { "100" }

      it "displays a not an integer error" do
        allow(io).to receive(:solicit_input).and_return(not_integer_like, integer_like)

        expect(io).to receive(:not_an_integer_error).once
        human.move("board", "players")
      end

      it "only returns a move (converted to integer) once it gets integer-like input" do
        allow(io).to receive(:solicit_input).and_return(not_integer_like, integer_like)

        expect(human.move("board", "players")).to eq(100)
      end
    end
  end
end
