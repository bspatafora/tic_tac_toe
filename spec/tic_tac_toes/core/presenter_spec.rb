require 'tic_tac_toes/core/board'
require 'tic_tac_toes/core/rules'
require 'tic_tac_toes/core/presenter'

describe TicTacToes::Core::Presenter do
  before do
    @presenter = TicTacToes::Core::Presenter
  end

  describe '#invalid_row_size' do
    it "returns a string containing the minimum and maximum allowed row sizes" do
      smallest_row_size = TicTacToes::Core::Rules::ROW_SIZE_RANGE.min.to_s
      largest_row_size = TicTacToes::Core::Rules::ROW_SIZE_RANGE.max.to_s

      expect(@presenter::INVALID_ROW_SIZE).to include(smallest_row_size, largest_row_size)
    end
  end

  describe '#token_solicitation' do
    it "returns a string containing the name of the player whose token is being picked" do
      player = "human"
      expect(@presenter.token_solicitation(player)).to include(player)
    end
  end

  describe '#game_over_notification' do
    it "returns a string containing the name of the winner" do
      winner = "X"
      expect(@presenter.game_over_notification(winner)).to include(winner)
    end
  end

  describe '#board' do
    it "returns a board string" do
      board = TicTacToes::Core::Board.new(row_size: 3)

      leading_spaces_regexp = /^[[:blank:]]+/
      board_string = <<-END.gsub(leading_spaces_regexp, '')

        [0]|[1]|[2]
        -----------
        [3]|[4]|[5]
        -----------
        [6]|[7]|[8]

      END

      expect(@presenter.board(board)).to eql(board_string)
    end
  end

  describe '#game_history_strings' do
    it 'Returns an array with a string for each game history' do
      history_double = double('history',
                             board_size: 9,
                             difficulty: 'Medium AI',
                             winner: 'X',
                             moves: [['A', 0], ['B', 4]])
      histories_array = [history_double, history_double]
      wrapper = double('wrapper', read_game_histories: histories_array)
      
      expect(@presenter.game_history_strings(wrapper).count).to eq(2)
    end
  end

  describe '#game_history_string' do
    before do
      @history_double = double('history',
                             board_size: 9,
                             difficulty: 'Medium AI',
                             winner: 'X',
                             moves: [['A', 0], ['B', 4]])
    end

    it 'Returns a string that includes the game history’s board size' do
      history_string = @presenter.game_history_string(@history_double)
      expect(history_string).to include('9')
    end

    it 'Returns a string that includes the game history’s difficulty' do
      history_string = @presenter.game_history_string(@history_double)
      expect(history_string).to include('Medium AI')
    end

    it 'Returns a string that includes the game history’s winner' do
      history_string = @presenter.game_history_string(@history_double)
      expect(history_string).to include('X')
    end

    it 'Returns a string that includes the game history’s move history' do
      history_string = @presenter.game_history_string(@history_double)
      expect(history_string).to include('A', '0', 'B', '4')
    end
  end
end
