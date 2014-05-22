require 'tic_tac_toe/Board'
require 'tic_tac_toe/Player_Factory'
require 'tic_tac_toe/Stringifier'

module TicTacToe
  module CommandLineIO
    def self.get_initial_game_state
      { board: TicTacToe::Board.new, players: get_player_array }
    end

    def self.get_player_array
      taken_tokens = []
      human_player = get_human_player(taken_tokens)
      taken_tokens << human_player.token
      computer_player = get_computer_player(taken_tokens)
      [human_player, computer_player]
    end

    def self.get_human_player(taken_tokens)
      begin
        token = get_token(:human)
        PlayerFactory.generate_human_player(token, taken_tokens)
      rescue InvalidToken
        get_human_player(taken_tokens)
      end
    end

    def self.get_computer_player(taken_tokens)
      begin
        token = get_token(:computer)
        difficulty = get_difficulty
        PlayerFactory.generate_computer_player(token, taken_tokens, difficulty)
      rescue InvalidToken, InvalidDifficulty
        get_computer_player(taken_tokens)
      end
    end

    def self.get_token(player)
      ask_for_token(player)
      solicit_input.to_sym
    end

    def self.ask_for_token(player)
      print Stringifier.stringify_ask_for_token(player)
    end

    def self.get_difficulty
      ask_for_difficulty
      solicit_input.downcase.to_sym
    end

    def self.ask_for_difficulty
      print TicTacToe::Stringifier.stringify_ask_for_difficulty
    end

    def self.make_move(board, players)
      begin
        ask_for_move
        Integer(solicit_input)
      rescue ArgumentError
        make_move(board, players)
      end
    end

    def self.ask_for_move
      print Stringifier.stringify_ask_for_move
    end

    def self.say_game_over(winner)
      winner = "Nobody" if winner.nil?
      print TicTacToe::Stringifier.stringify_game_over(winner)
    end

    def self.draw_board(board)
      print TicTacToe::Stringifier.stringify_board(board)
    end

    private

    def self.solicit_input
      gets.chomp
    end
  end
end
