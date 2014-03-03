require 'spec_helper'

describe 'Tetris::Tetrimino' do
  it 'should exist' do
    Tetris::Tetrimino.class.should == Class
  end
  
  describe 'attributes' do
    before do
      @attributes = {
        :height    => 2,
        :width     => 3,
        :shape     => [0,1,0,
                       1,1,1]
      }
      @tetrimino = Tetris::Tetrimino.new( @attributes )
    end

    it 'should have a height' do
      @tetrimino.height.should == @attributes[:height]
    end

    it 'should have a width' do
      @tetrimino.width.should == @attributes[:width]
    end

    it 'should have a shape' do
      @tetrimino.shape.should == @attributes[:shape]
    end
  end

  describe 'class methods' do
    describe '#sample' do
      it 'should return a random Tetrimino piece' do
        Tetris::Tetrimino.sample.class == Tetris::Tetrimino
      end
    end
  end
end