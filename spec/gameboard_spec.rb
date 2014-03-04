require 'spec_helper'

describe 'Tetris::Gameboard' do
  it 'should exist' do
    Tetris::Gameboard.class.should == Class
  end
  
  describe 'attributes' do
    before do
      @height    = 12
      @width     = 6
      @gameboard = Tetris::Gameboard.new( @height, @width )
    end

    it 'should have a height' do
      @gameboard.height.should == @height
    end

    it 'should have a width' do
      @gameboard.width.should == @width
    end

    it 'should have a well (game grid)' do
      @gameboard.well.size.should == @height * @width
    end
  end

  describe 'methods' do
    before do
      @gameboard = Tetris::Gameboard.new( 4, 3, [ 1,0,0,
                                                  1,1,0,
                                                  1,1,1,
                                                  1,1,1 ] )
    end

    # ===== Row stuff:

    describe '#row' do
      it 'should return the appropriate row based on index' do
        @gameboard.row(0).should == [1,0,0]
        @gameboard.row(1).should == [1,1,0]
        @gameboard.row(2).should == [1,1,1]
        @gameboard.row(3).should == [1,1,1]
      end
    end

    # ===== Column stuff:

    describe '#column' do
      it 'should return the appropriate column based on index' do
        @gameboard.column(0).should == [1,1,1,1]
        @gameboard.column(1).should == [0,1,1,1]
        @gameboard.column(2).should == [0,0,1,1]
      end
    end
  end
end