require 'spec_helper'

describe 'Tetris::Game' do
  it 'should exist' do
    Tetris::Game.class.should == Class
  end

  it 'should have a gameboard' do
    Tetris::Game.new(10, 10).gameboard.class.should == Tetris::Gameboard
  end
end