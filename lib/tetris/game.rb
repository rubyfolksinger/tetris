module Tetris
  class Game
    attr_accessor :gameboard, :current_piece, :next_piece

    def initialize( height=20, width=10 )
      @gameboard     = Tetris::Gameboard.new( height, width, nil )
      @current_piece = Tetris::Tetrimino.sample
      @next_piece    = Tetris::Tetrimino.sample
    end

    def play
      until game_over do
        turn
        game_over = true if @gameboard.filled?
      end
    end

    def turn!
      robo_player_turn!
      @current_piece = @next_piece
      @next_piece    = Tetris::Tetrimino.sample
      @gameboard.clear_rows!
    end

    def robo_player_turn!
      @gameboard.drop!( @current_piece, Robot.decide( @gameboard, @current_piece ) )
    end
  end
end