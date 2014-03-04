module Tetris
  class Gameboard
    attr_accessor :height, :width, :well

    def initialize( height, width, well=nil )
      @height = height
      @width  = width
      @well   = well || Array.new( height * width, 0 )
    end
    
    def drop!( piece, column )
    end

    # ===== Row stuff:
  
    def row( row_index )
      @well.each_slice( @width ).to_a[ row_index ]
    end
    
    # ===== Column stuff:
  
    def column( column_index )
      @well.each_slice( @width ).collect{|r| r[ column_index ] }
    end
  end
end