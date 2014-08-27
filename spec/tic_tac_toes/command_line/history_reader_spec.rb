require 'tic_tac_toes/command_line/history_reader'

describe TicTacToes::CommandLine::HistoryReader do
  before do
    @history_double = double('history',
                             board_size: 9,
                             difficulty: 'Medium AI',
                             winner: 'X',
                             moves: [['A', 0], ['B', 4]])
  end

  describe '#game_history_strings' do
    it 'Returns an array with a string for each game history' do
      histories_array = [@history_double, @history_double]
      wrapper = double('wrapper', read_game_histories: histories_array)
      
      expect(TicTacToes::CommandLine::HistoryReader.new(wrapper).game_history_strings.count).to eq(2)
    end
  end

  describe '#game_history_string' do
    before do
      wrapper_double = double('wrapper')
      @history_reader = TicTacToes::CommandLine::HistoryReader.new(wrapper_double)
    end

    it 'Returns a string that includes the game history’s board size' do
      history_string = @history_reader.game_history_string(@history_double)
      expect(history_string).to include('9')
    end

    it 'Returns a string that includes the game history’s difficulty' do
      history_string = @history_reader.game_history_string(@history_double)
      expect(history_string).to include('Medium AI')
    end

    it 'Returns a string that includes the game history’s winner' do
      history_string = @history_reader.game_history_string(@history_double)
      expect(history_string).to include('X')
    end

    it 'Returns a string that includes the game history’s move history' do
      history_string = @history_reader.game_history_string(@history_double)
      expect(history_string).to include('A', '0', 'B', '4')
    end
  end
end
