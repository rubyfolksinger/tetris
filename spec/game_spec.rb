require 'spec_helper'

describe 'Tetris::Game' do
  it 'should exist' do
    Tetris::Game.class.should == Class
  end

  it 'should have a gameboard' do
    Tetris::Game.new( 10,10 ).gameboard.class.should == Tetris::Gameboard
  end

  it 'should have a current_piece' do
    Tetris::Game.new( 5,5 ).current_piece.class.should == Tetris::Tetrimino
  end

  it 'should have a next_piece' do
    Tetris::Game.new( 10,10 ).current_piece.class.should == Tetris::Tetrimino
  end
end