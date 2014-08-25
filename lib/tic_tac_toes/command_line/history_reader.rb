require 'tic_tac_toes/command_line/prompt'

module TicTacToes
  module CommandLine
    class HistoryReader
      def initialize(wrapper)
        @wrapper = wrapper
      end

      def display_game_histories
        game_histories = @wrapper.read_game_histories
        game_histories.each { |history| Prompt.display(game_history_string(history)) }
        nil
      end

      def game_history_string(history)
        history_string = ''
        history_string << "Board size: #{history.board_size.to_s}\n"
        history_string << "Difficulty: #{history.difficulty}\n"
        history_string << "Winner: #{history.winner}\n"
        history_string << "Move history:\n"
        history.moves.each { |move| history_string << "  #{move.join(' -> ')}\n" }
        history_string << "\n"
        history_string
      end
    end
  end
end
