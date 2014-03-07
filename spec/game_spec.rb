require 'spec_helper'
require 'pry'

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

  describe '#turn!' do
    it 'should replace current_piece with next_piece and choose a new next piece after dropping a piece' do
      game = Tetris::Game.new( 3,6 )
      next_piece = game.next_piece
      game.turn!
      game.current_piece.should === next_piece
    end

    context 'new game' do
      before do
        stub( Tetris::Tetrimino ).sample { Tetris::Tetrimino.new( height: 2, width: 2, shape: [ 1,1,
                                                                                                1,1 ] ) } 
      end

      it 'should place the current piece in the bottom-left corner' do
        game = Tetris::Game.new( 3,6 )
        game.turn!
        game.gameboard.well.should == [ 0,0,0,0,0,0,
                                        1,1,0,0,0,0,
                                        1,1,0,0,0,0 ]
      end
    end
  end
end