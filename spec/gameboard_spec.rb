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

    describe '#clear_row!' do
      it 'should clear the specified row' do
        @gameboard.clear_row!(3)
        @gameboard.well.should == [ 0,0,0,
                                    1,0,0,
                                    1,1,0,
                                    1,1,1 ]
      end
    end

    describe '#clear_rows!' do
      it 'should clear all clearable rows' do
        @gameboard.clear_rows!
        @gameboard.well.should == [ 0,0,0,
                                    0,0,0,
                                    1,0,0,
                                    1,1,0 ]
      end
    end

    describe '#drop!' do
      before do
        @piece = Tetris::Tetrimino.new( :height => 2,
                                        :width  => 2,
                                        :shape => [ 1,1,
                                                    1,1 ] )
      end
      
      it 'should place the piece in the specified column' do
        @gameboard = Tetris::Gameboard.new( 3, 3, [ 0,0,0,
                                                    0,0,0,
                                                    0,0,0 ] )
        @gameboard.drop!( @piece, 1 )
        @gameboard.well.should == [ 0,0,0,
                                    0,1,1,
                                    0,1,1 ]
      end

      it 'should place the piece atop other pieces in the specified column' do
        @gameboard = Tetris::Gameboard.new( 3, 3, [ 0,0,0,
                                                    0,0,0,
                                                    2,2,2 ] )
        @gameboard.drop!( @piece, 1 )
        @gameboard.well.should == [ 0,1,1,
                                    0,1,1,
                                    2,2,2 ]
      end

      it 'should create a hole when hanging over a space' do
        @gameboard = Tetris::Gameboard.new( 3, 3, [ 0,0,0,
                                                    0,0,0,
                                                    2,0,2 ] )
        @gameboard.drop!( @piece, 0 )
        @gameboard.well.should == [ 1,1,0,
                                    1,1,0,
                                    2,0,2 ]
      end
      
      it 'should raise an error if the piece is too wide for the column (would extend over the edge of the board)' do
        expect { @gameboard.drop!( @piece, 999 )}.to raise_error
      end

      it 'should raise an error if a negative index is passed' do
        expect { @gameboard.drop!( @piece, -1 )}.to raise_error
      end
    end

    # ===== Row stuff:

    describe 'rows' do
      describe '#row' do
        it 'should return the appropriate row based on index' do
          @gameboard.row( 0 ).should == [ 1,0,0 ]
          @gameboard.row( 1 ).should == [ 1,1,0 ]
          @gameboard.row( 2 ).should == [ 1,1,1 ]
          @gameboard.row( 3 ).should == [ 1,1,1 ]
        end
      end
      

      describe '#clearable_rows' do
        it 'should return the row_index of clearable rows' do
          @gameboard.clearable_rows.should == [ 2,3 ]
        end

        it 'should return an empty array if no rows are clearable' do
          [2,3].each{|row_index| @gameboard.clear_row!( row_index ) }
          @gameboard.clearable_rows.should == []
        end
      end
      
      describe '#row_clearable?' do
        it 'should return true if a row is filled' do
          @gameboard.row_clearable?( 0 ).should be_false
          @gameboard.row_clearable?( 1 ).should be_false
        end

        it 'should return false if a row has any holes' do
          @gameboard.row_clearable?( 2 ).should be_true
          @gameboard.row_clearable?( 3 ).should be_true
        end
      end
    end
    
    describe 'columns' do
      before do
        @gameboard = Tetris::Gameboard.new( 4, 4, [ 0,0,0,2,
                                                    0,0,3,3,
                                                    0,1,1,3,
                                                    0,1,1,0 ] )
      end

      describe '#column' do
        it 'should return the specified column' do
          @gameboard.column( 0 ).should == [ 0,0,0,0 ]
          @gameboard.column( 1 ).should == [ 0,0,1,1 ]
          @gameboard.column( 2 ).should == [ 0,3,1,1 ]
          @gameboard.column( 3 ).should == [ 2,3,3,0 ]
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

      describe '#columns_heights_beneath_piece' do
        it 'should return the height of blocks in the column' do
          piece = Tetris::Tetrimino.new( :height => 2, :width => 2, :shape => [ 1,1,
                                                                                1,1 ] )
          @gameboard.column_heights_beneath_piece( piece, 0 ).should == [ 0,2 ]
          @gameboard.column_heights_beneath_piece( piece, 1 ).should == [ 2,3 ]
          @gameboard.column_heights_beneath_piece( piece, 2 ).should == [ 3,4 ]
        end
      end

      describe '#filled?' do
        it 'should return true if any column is filled with blocks' do
          gameboard = Tetris::Gameboard.new( 4, 4, [ 0,0,0,2,
                                                     0,0,3,3,
                                                     0,1,1,3,
                                                     0,1,1,0 ] )
          gameboard.filled?.should be_true
        end

        it 'should return false if a column has one or more spaces at the top' do
          gameboard = Tetris::Gameboard.new( 4, 4, [ 0,0,0,0,
                                                     0,0,3,3,
                                                     0,1,1,3,
                                                     0,1,1,3 ] )
          gameboard.filled?.should be_false
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