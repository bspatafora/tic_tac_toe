require 'tic_tac_toes/core/board'
require 'tic_tac_toes/core/io'
require 'tic_tac_toes/core/strings'

describe TicTacToes::Core::IO do
  let(:strings)  { TicTacToes::Core::Strings }
  let(:prompt)   { double("prompt", solicit_input: 0, display: true, display_red: true) }
  let(:io)       { TicTacToes::Core::IO.new(prompt) }

  describe '#get_row_size' do
    it "displays a row size solicitation" do
      expect(io).to receive(:row_size_solicitation)
      io.get_row_size
    end

    context 'when given not-integer-like input' do
      let(:not_integer_like)  { "string" }
      let(:integer_like)      { "100" }

      it "displays a not an integer error" do
        allow(prompt).to receive(:solicit_input).and_return(not_integer_like, integer_like)

        expect(io).to receive(:not_an_integer_error).once
        io.get_row_size
      end

      it "only returns a row size (converted to integer) once it gets integer-like input" do
        allow(prompt).to receive(:solicit_input).and_return(not_integer_like, integer_like)

        expect(io.get_row_size).to eq(100)
      end
    end
  end


  describe '#get_token' do
    let(:player) { double("player") }

    it "displays a token solicitation with the name of the player whose token is to be set" do
      expect(io).to receive(:token_solicitation).with(player)
      io.get_token(player)
    end

    it "returns the user input" do
      token = "X"
      allow(prompt).to receive(:solicit_input) { token }

      expect(io.get_token(player)).to equal(token)
    end
  end


  describe '#get_difficulty' do
    let(:difficulty) { "HARD" }

    it "displays a difficulty solicitation" do
      allow(prompt).to receive(:solicit_input) { difficulty }

      expect(io).to receive(:difficulty_solicitation)
      io.get_difficulty
    end

    it "returns the user input (downcased and converted into a symbol)" do
      allow(prompt).to receive(:solicit_input) { difficulty }

      expect(io.get_difficulty).to equal(:hard)
    end
  end


  describe '#draw_board' do
    it "displays a board string" do
      board = TicTacToes::Core::Board.new
      board_string = strings.board(board)

      expect(prompt).to receive(:display).with(board_string)
      io.draw_board(board)
    end
  end


  describe '#invalid_row_size_error' do
    it "displays a red invalid row size message" do
      expect(prompt).to receive(:display_red).with(strings::INVALID_ROW_SIZE)
      io.invalid_row_size_error
    end
  end


  describe '#invalid_token_error' do
    it "displays a red invalid token message" do
      expect(prompt).to receive(:display_red).with(strings::INVALID_TOKEN)
      io.invalid_token_error
    end
  end


  describe '#invalid_difficulty_error' do
    it "displays a red invalid difficulty message" do
      expect(prompt).to receive(:display_red).with(strings::INVALID_DIFFICULTY)
      io.invalid_difficulty_error
    end
  end


  describe '#invalid_move_error' do
    it "displays a red invalid move message" do
      expect(prompt).to receive(:display_red).with(strings::INVALID_MOVE)
      io.invalid_move_error
    end
  end


  describe '#thinking_notification' do
    it "displays a red thinking message" do
      expect(prompt).to receive(:display_red).with(strings::THINKING)
      io.thinking_notification
    end
  end


  describe '#game_over_notification' do
    it "displays a game over message with the name of the winner" do
      winner = 'X'
      game_over_message = strings.game_over_notification(winner)

      expect(prompt).to receive(:display).with(game_over_message)
      io.game_over_notification(winner)
    end
  end


  describe '#move_solicitation' do
    it "displays a move solicitation message" do
      expect(prompt).to receive(:display).with(strings::MOVE_SOLICITATION)
      io.move_solicitation
    end
  end


  describe '#not_an_integer_error' do
    it "displays a red not an integer message" do
      expect(prompt).to receive(:display_red).with(strings::NOT_AN_INTEGER)
      io.not_an_integer_error
    end
  end


  describe '#red' do
    it "calls its IO's red method with the passed message" do
      expect(io).to receive(:red).with("message")
      io.red("message")
    end
  end


  describe '#blue' do
    it "calls its IO's blue method with the passed message" do
      expect(io).to receive(:blue).with("message")
      io.blue("message")
    end
  end
end
