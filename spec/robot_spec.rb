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
        :shape     => [ 1,1,
                        1,1 ]
      }
      @piece = Tetris::Tetrimino.new( @attributes )
    end

    it 'should choose the leftmost column if the board is empty' do
      Tetris::Robot.decide( @gameboard, @piece ).should == 0
    end

    it 'should choose the third column if a 2x2 block is in the bottom left' do
      @gameboard.drop!( @piece, 0 )
      Tetris::Robot.decide( @gameboard, @piece ).should == 3
    end

    it 'should choose the fifth column if two 2x2 blocks are in the bottom left' do
      @gameboard.drop!( @piece, 0 )
      @gameboard.drop!( @piece, 2 )
      Tetris::Robot.decide( @gameboard, @piece ).should == 5
    end

    it 'should choose the sixth column if two 2x2 blocks are in the bottom left' do
      @gameboard.drop!( @piece, 0 )
      @gameboard.drop!( @piece, 3 )
      Tetris::Robot.decide( @gameboard, @piece ).should == 6
    end
  end
end