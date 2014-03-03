require 'spec_helper'

describe 'Tetris::Gameboard' do
  it 'should exist' do
    Tetris::Gameboard.class.should == Class
  end
  
  describe 'attributes' do
    before do
      @gameboard = Tetris::Gameboard.new(12, 6)
    end

    it 'should have a height' do
      @gameboard.height.should == 12
    end

    it 'should have a width' do
      @gameboard.width.should == 6
    end
  end
end