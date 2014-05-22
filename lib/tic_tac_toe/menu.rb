require 'tic_tac_toe/board'
require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/player_factory'

module TicTacToe
  class Menu
    def initialize(io: CommandLineIO)
      @io = io
    end

    def get_initial_game_state
      { board: Board.new, players: get_player_array }
    end

    def get_player_array
      taken_tokens = []
      human_player = get_human_player(taken_tokens)
      taken_tokens << human_player.token
      computer_player = get_computer_player(taken_tokens)
      [human_player, computer_player]
    end

    def get_human_player(taken_tokens)
      begin
        token = @io.get_token(:human)
        PlayerFactory.generate_human_player(token, taken_tokens)
      rescue InvalidToken
        get_human_player(taken_tokens)
      end
    end

    def get_computer_player(taken_tokens)
      begin
        token = @io.get_token(:computer)
        difficulty = @io.get_difficulty
        PlayerFactory.generate_computer_player(token, taken_tokens, difficulty)
      rescue InvalidToken, InvalidDifficulty
        get_computer_player(taken_tokens)
      end
    end
  end
end
