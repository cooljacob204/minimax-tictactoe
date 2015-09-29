require 'spec_helper'

describe '#play' do

  let(:board) { Board.new }
  let(:ai_min) { Computer.new("x", Min.new) }
  let(:ai_max) { Computer.new("o", Max.new) }

  it "should add the player's mark on the board when given a position" do
    ai_min.play(board, 0)
    ai_max.play(board, 0)
    ai_max.play(board, 1)
    expect(board.state).to eq(["x","o"," "," "," "," "," "," "," "])
  end
end
