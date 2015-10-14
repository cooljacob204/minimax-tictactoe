require 'pry'

require_relative 'tictactoe_board'
require_relative 'game'
require_relative 'human_player'
require_relative 'computer_player'

################################################
class Tictactoe < Game
  WINNING_LINES = [
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # Vertical lines
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # Horizontal lines
    [0, 4, 8], [2, 4, 6] # Diagonals.
  ]

  def initialize players, board=nil
    board ||= Board.new
    super board, players
  end

  def winner
    saved_positions = []
    WINNING_LINES.each do |winning_line|
      @players.each do |player|
        return player if winning_line.all? { |position| @board.state[position] == player.mark }
      end
      saved_positions.clear
    end

    nil
  end

  def draw?
    !@board.state.include?(nil)
  end

  def get_new_game(position)
    board = @board.get_new_state(position, current_player.mark)
    self.class.new @players.rotate, board
  end
end
