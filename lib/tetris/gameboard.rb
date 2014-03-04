module Tetris
  class Gameboard
    attr_accessor :height, :width, :well

    def initialize( height, width, well=nil )
      @height = height
      @width  = width
      @well   = well || Array.new( height * width, 0 )
    end
    
    def drop!( piece, column_index )
      # TODO: ensure piece is within well boundaries (doesn't spill off to the right)
    end

    def column_heights_beneath_piece( piece, column_index )
      ( column_index...( column_index + piece.width ) ).collect{|index| column_height( index ) }
    end

    def column_height( column_index )
      top_block_position( column_index ) ? @height - top_block_position( column_index ) : 0
    end

    def top_block( column_index )
      column( column_index ).select{|c| c != 0 }.first
    end

    def top_block_position( column_index )
      column( column_index ).index( top_block( column_index ) )
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