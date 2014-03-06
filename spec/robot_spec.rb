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
        :width     => 2,
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
      Tetris::Robot.decide( @gameboard, @piece ).should == 2
    end

    it 'should choose the fifth column if two 2x2 blocks are in the bottom left' do
      [0,2].each{|position|  @gameboard.drop!( @piece, position ) }
      Tetris::Robot.decide( @gameboard, @piece ).should == 4
    end
    
    it 'should choose the sixth column if two 2x2 blocks with a space in-between them are in the bottom left' do
      [0,3].each{|position|  @gameboard.drop!( @piece, position ) }
      Tetris::Robot.decide( @gameboard, @piece ).should == 5
    end

    it 'should choose the first column if the bottom row is filled aside from 1-wide gaps' do
      [0,2,4,7].each{|position|  @gameboard.drop!( @piece, position ) }
      Tetris::Robot.decide( @gameboard, @piece ).should == 0
    end
  end
end