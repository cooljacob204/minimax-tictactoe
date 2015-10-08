# Require all files in the lib folder
Dir[File.dirname(__FILE__) + '/*.rb'].each do |file|
  require_relative File.basename(file, File.extname(file))
end
require 'pry'

class Game
  attr_accessor :board, :players, :human, :computer

  def initialize board, players
    @board = board
    @players = players
  end

  def play_the_game
    until over?
      player.play(board, player.next_move(self))
      take_turns @players
    end
  end

  def over?
    !!winner || draw?
  end

  def get_new_game(position)
    board = @board.dup
    players = @players.dup
    game = self.class.new(board, players)
    game.board = game.board.get_new_state(position, game.player.mark)
    players.rotate!
    game
  end

  def player
    @players[0]
  end

  def human
    @players.select { |player| player.is_a?(Human)}[0]
  end

  def computer
    @players.select { |player| player.is_a?(Computer)}[0]
  end

  private

  def take_turns players
    @players.rotate!
  end

end

class Tictactoe < Game

  WIN_POS = [[0, 3, 6], [1, 4, 7], [2, 5, 8],
             [0, 1, 2], [3, 4, 5], [6, 7, 8],
             [0, 4, 8], [2, 4, 6]]

  def initialize board, players
    super board, players
  end

  def winner
    saved_positions = []
    WIN_POS.each do |some|
      some.each { |position| saved_positions << @board.state[position] }

      @players.each do |player|
        return player if saved_positions.all? { |i| i == player.mark }
      end
      saved_positions.clear
    end
    return nil
  end

  def draw?
    !@board.state.include?(" ")
  end

end

# $0 represents name of file that is being run from terminal
# For rspec, $0 would be something like rspec.rb

if __FILE__ == $0
  board = Board.new
  computer = Computer.new("X", Max.new)
  human = Human.new("O")
  players = [computer, human]

  game = Tictactoe.new(board, players)

  game.play_the_game
  board.display
  winner = game.winner
  if winner
    puts "Winner: #{winner.name} as #{winner.mark}."
  else
    puts "No winner this time. Try again!"
  end
end
