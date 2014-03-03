module Tetris
  class Gameboard
    attr_accessor :height, :width, :well

    def initialize( height, width, well=nil )
      @height = height
      @width  = width
      @well   = well || Array.new( height * width, 0 )
    end
  end
end