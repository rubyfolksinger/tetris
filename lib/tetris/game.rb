module Tetris
  class Game
    attr_accessor :gameboard

    def initialize( height=20, width=10 )
      @gameboard = Tetris::Gameboard.new( height, width, nil )
    end
  end
end