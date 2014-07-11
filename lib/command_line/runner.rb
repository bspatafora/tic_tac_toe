module CommandLine
  class Runner
    def initialize(io, menu, game_state_factory, rules)
      @io = io
      @menu = menu
      @game_state_factory = game_state_factory
      @rules = rules
    end

    def run
      board, players = @menu.get_board, @menu.get_players
      game_state = @game_state_factory.generate_game_state(board, players)

      take_turn(game_state) until @rules.game_over?(game_state.board, game_state.players)
      end_game(game_state)
    end

    private

    def take_turn(game_state)
      @io.draw_board(game_state.board)
      @io.thinking_notification if game_state.current_player.needs_to_think

      move = game_state.current_player.place_and_return_move(game_state.board, game_state.players)
      game_state.turn_over(move)
    end

    def end_game(game_state)
      @io.draw_board(game_state.board)

      winner = @rules.determine_winner(game_state.board, game_state.players)
      game_state.game_over(winner)

      @io.game_over_notification(winner)
    end
  end
end
