require 'tic_tac_toes/board'
require 'tic_tac_toes/rules'
require 'tic_tac_toes/strings'

describe TicTacToes::Strings do
  let(:strings) { TicTacToes::Strings }

  describe '#invalid_row_size' do
    it "returns a string containing the minimum and maximum allowed row sizes" do
      smallest_row_size = TicTacToes::Rules::ROW_SIZE_RANGE.min.to_s
      largest_row_size = TicTacToes::Rules::ROW_SIZE_RANGE.max.to_s

      expect(strings::INVALID_ROW_SIZE).to include(smallest_row_size, largest_row_size)
    end
  end

  describe '#token_solicitation' do
    it "returns a string containing the name of the player whose token is being picked" do
      player = "human"
      expect(strings.token_solicitation(player)).to include(player)
    end
  end

  describe '#game_over_notification' do
    it "returns a string containing the name of the winner" do
      winner = "X"
      expect(strings.game_over_notification(winner)).to include(winner)
    end
  end

  describe '#board' do
    it "returns a board string" do
      board = TicTacToes::Board.new(row_size: 3)

      leading_spaces_regexp = /^[[:blank:]]+/
      board_string = <<-END.gsub(leading_spaces_regexp, '')

        [0]|[1]|[2]
        -----------
        [3]|[4]|[5]
        -----------
        [6]|[7]|[8]

      END

      expect(strings.board(board)).to eql(board_string)
    end
  end
end
