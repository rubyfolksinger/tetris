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

    describe '#drop!' do
      it 'should place the piece in the specified column' do
        pending
      end

      it 'should place the piece atop other pieces in the specified column' do
        pending
      end

      it 'should place the piece at the correct height if the piece should rest atop pieces in other columns' do
        pending
      end
    end

    # ===== Row stuff:

    describe '#row' do
      it 'should return the appropriate row based on index' do
        @gameboard.row( 0 ).should == [1,0,0]
        @gameboard.row( 1 ).should == [1,1,0]
        @gameboard.row( 2 ).should == [1,1,1]
        @gameboard.row( 3 ).should == [1,1,1]
      end
    end

    describe 'columns' do
      before do
        @gameboard = Tetris::Gameboard.new( 4, 4, [0,0,0,2,
                                                   0,0,3,3,
                                                   0,1,1,3,
                                                   0,1,1,0] )
      end

      describe '#column' do
        it 'should return the specified column' do
          @gameboard.column( 0 ).should == [0,0,0,0]
          @gameboard.column( 1 ).should == [0,0,1,1]
          @gameboard.column( 2 ).should == [0,3,1,1]
          @gameboard.column( 3 ).should == [2,3,3,0]
        end
      end

      describe '#column_height' do
        it 'should return the height of blocks in the column' do
          @gameboard.column_height( 0 ).should == 0
          @gameboard.column_height( 1 ).should == 2
          @gameboard.column_height( 2 ).should == 3
          @gameboard.column_height( 3 ).should == 4
        end
      end

      describe '#top_block' do
        it 'should return character used by the top block' do
          @gameboard.top_block( 0 ).should == nil
          @gameboard.top_block( 1 ).should == 1
          @gameboard.top_block( 2 ).should == 3
          @gameboard.top_block( 3 ).should == 2
        end
      end

      describe '#top_block_position' do
        it 'should return the position of the character used by the top block' do
          @gameboard.top_block_position( 0 ).should == nil
          @gameboard.top_block_position( 1 ).should == 2
          @gameboard.top_block_position( 2 ).should == 1
          @gameboard.top_block_position( 3 ).should == 0
        end
      end
    end
  end
end