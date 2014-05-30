require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/board'
require 'tic_tac_toe/rules'
require 'tic_tac_toe/stringifier'

describe TicTacToe::Stringifier do
  let(:rules) { TicTacToe::Rules }
  let(:stringifier) { TicTacToe::Stringifier }

  describe '#invalid_row_size' do
    it "returns a string containing the minimum and maximum allowed row sizes" do
      expect(stringifier.invalid_row_size).
        to include(rules::ROW_SIZE_RANGE.min.to_s, rules::ROW_SIZE_RANGE.max.to_s)
    end
  end

  describe '#token_solicitation' do
    it "returns a string containing the name of the player whose token is being picked" do
      player = "human"

      expect(stringifier.token_solicitation(player)).
        to include(player)
    end
  end

  describe '#game_over_notification' do
    it "returns a string containing the name of the winner" do
      winner = "X"

      expect(stringifier.game_over_notification(winner)).
        to include(winner)
    end
  end

  describe '#stringify_board' do
    it "returns a stringified board" do
      leading_spaces_regexp = /^[[:blank:]]+/
      board_string = <<-END.gsub(leading_spaces_regexp, '')

        [0]|[1]|[2]
        -----------
        [3]| X |[5]
        -----------
        [6]|[7]|[8]

      END

      board = TicTacToe::Board.new(row_size: 3)
      board.place(:X, 4)
      expect(stringifier.board(board)).to eql(board_string)
    end
  end
end
