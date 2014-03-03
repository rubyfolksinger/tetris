module Tetris
  class Gameboard
    attr_accessor :height, :width
    
    def initialize( height, width )
      @height = height
      @width  = width
    end
  end
end