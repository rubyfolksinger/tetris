require 'spec_helper'

describe 'Tetris::Robot' do
  it 'should exist' do
    Tetris::Robot.class.should == Class
  end

  describe '#decide' do
    before do
      @gameboard = Tetris::Gameboard.new( 20, 10 )
      @attributes = {
        :height    => 2,
        :width     => 3,
        :shape     => [0,1,0,
                       1,1,1]
      }
      @piece = Tetris::Tetrimino.new( @attributes )
    end

    it 'should choose the leftmost column if the board is empty' do
      Tetris::Robot.decide( @gameboard, @piece ).should == 0
    end
  end
end