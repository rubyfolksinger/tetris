require 'spec_helper'

describe 'Tetris::Tetrimino' do
  it 'should exist' do
    Tetris::Tetrimino.class.should == Class
  end
  
  describe 'attributes' do
    before do
      @height    = 2
      @width     = 3
      @shape     = [0,1,0,
                    1,1,1]
      @tetrimino = Tetris::Tetrimino.new( @height, @width, @shape )
    end

    it 'should have a height' do
      @tetrimino.height.should == @height
    end

    it 'should have a width' do
      @tetrimino.width.should == @width
    end

    it 'should have a shape' do
      @tetrimino.shape.should == @shape
    end
  end
end