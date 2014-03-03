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
end