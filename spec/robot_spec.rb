require 'spec_helper'

describe 'Tetris::Robot' do
  it 'should exist' do
    Tetris::Robot.class.should == Class
  end

  describe '#decide' do
    context 'with square' do
      before do
        @gameboard = Tetris::Gameboard.new( 20, 10 )
        @attributes = { height: 2, width: 2, shape: [ 1,1,
                                                      1,1 ] }
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
    
    context 'with tall line' do
      before do
        @gameboard  = Tetris::Gameboard.new( 20, 10 )
        @attributes = { height: 4, width: 1, shape: [ 1,
                                                      1,
                                                      1,
                                                      1 ] }
        @piece      = Tetris::Tetrimino.new( @attributes )
      end
      
      it 'should choose the leftmost column if the board is empty' do
        Tetris::Robot.decide( @gameboard, @piece ).should == 0
      end

      it 'should choose the second column if a tall line is in the first column' do
        @gameboard.drop!( @piece, 0)
        Tetris::Robot.decide( @gameboard, @piece ).should == 1
      end

      it 'should choose the second column (between two filled columns)' do
        @gameboard.drop!( @piece, 0)
        @gameboard.drop!( @piece, 2)
        Tetris::Robot.decide( @gameboard, @piece ).should == 1
      end
    end

    context 'with wide line' do
      before do
        @gameboard  = Tetris::Gameboard.new( 20, 10 )
        @attributes = { height: 1, width: 4, shape: [ 1,1,1,1 ] }
        @piece      = Tetris::Tetrimino.new( @attributes )
      end
      
      it 'should choose the leftmost column if the board is empty' do
        Tetris::Robot.decide( @gameboard, @piece ).should == 0
      end

      it 'should choose the fifth column if the board has a tetrimino in the first column' do
        @gameboard.drop!( @piece, 0)
        Tetris::Robot.decide( @gameboard, @piece ).should == 4
      end
      
      it 'should choose the leftmost column if the first row is not wide enough for the piece to fit' do
        @gameboard.drop!( @piece, 0)
        @gameboard.drop!( @piece, 4)
        Tetris::Robot.decide( @gameboard, @piece ).should == 0
      end
      
      it 'should hang over other pieces' do
        filler_block = Tetris::Tetrimino.new( { height: 1, width: 1, shape: [ 1 ] } )
        @gameboard.drop!( @piece, 0)
        @gameboard.drop!( filler_block, 0)
        @gameboard.drop!( @piece, 5)
        Tetris::Robot.decide( @gameboard, @piece ).should == 1
      end
    end
  end
end