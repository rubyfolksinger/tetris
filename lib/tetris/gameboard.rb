module Tetris
  class Gameboard
    attr_accessor :height, :width, :well

    def initialize( height, width, well=nil )
      @height = height
      @width  = width
      @well   = well || Array.new( height * width, 0 )
    end
    
    def drop!( piece, column_index )
      raise 'Out of bounds' if ( column_index + piece.width > @width ) ||
                               column_index < 0

      drop_height = column_heights_beneath_piece( piece, column_index ).max

      # draw the piece in the well

      piece.shape.each_slice( piece.width ).to_a.each_with_index do |shape_row, shape_row_index|
        shape_row.each_with_index do |shape_col, shape_column_index|
          row_index = ( @height - drop_height - piece.height ) * @width + ( @width * shape_row_index )
          well_index = row_index + column_index + shape_column_index
          @well[ well_index ] = 1
        end

      end
    end

    # ===== Row stuff:
  
    def add_blank_row_to_top
      @well = Array.new( @width, 0 ) + @well
    end

    def clear_row!( row_index )
      @well.slice!( row_index * @width, @width )
      add_blank_row_to_top
    end

    def clear_rows!
      clearable_rows.each{|row_index| clear_row!( row_index ) }
    end

    def clearable_rows
      0.upto( @width ).select{|row_index| row_index if row_clearable?( row_index ) }
    end

    def row( row_index )
      @well.each_slice( @width ).to_a[ row_index ]
    end
  
    def row_clearable?( row_index )
      ! row( row_index ).include?( 0 )
    end

    # ===== Column stuff:
  
    def column( column_index )
      @well.each_slice( @width ).collect{|r| r[ column_index ] }
    end

    def column_height( column_index )
      top_block_position( column_index ) ? @height - top_block_position( column_index ) : 0
    end

    def column_heights_beneath_piece( piece, column_index )
      ( column_index...( column_index + piece.width ) ).collect{|index| column_height( index ) }
    end

    def all_column_heights
      0.upto( @width - 1 ).collect{|column_index| column_height( column_index ) }
    end

    def filled?
      0.upto( @width - 1 ).any?{|column_index| column_height( column_index ) >= @height } 
    end

    def top_block( column_index )
      column( column_index ).select{|c| c != 0 }.first
    end

    def top_block_position( column_index )
      column( column_index ).index( top_block( column_index ) )
    end
    
    def to_s
      @well.each_slice( @width )
        .collect{|row| row.join }
        .join( "\n" )
        .gsub( /0/, '_' )
    end
  end
end