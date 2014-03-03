module Tetris
  class Game
    attr_accessor :gameboard, :current_piece, :next_piece

    def initialize( height=20, width=10 )
      @gameboard     = Tetris::Gameboard.new( height, width, nil )
      @current_piece = Tetris::Tetrimino.sample
      @next_piece    = Tetris::Tetrimino.sample
    end
  end
end