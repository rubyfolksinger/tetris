module Tetris
  class Tetrimino
    attr_accessor :height, :width, :shape

    SHAPES = [ 
               { :height => 2, :width => 2, :shape => [ 1,1,1,1] }
             ]

    def initialize( options )
      @height = options[:height]
      @width  = options[:width]
      @shape  = options[:shape]
    end

    def self.sample
      Tetrimino.new( SHAPES.sample )
    end
  end
end