module Tetris
  class Tetrimino
    attr_accessor :height, :width, :shape

    def initialize( height, width, shape )
      @height = height
      @width  = width
      @shape  = shape
    end
  end
end