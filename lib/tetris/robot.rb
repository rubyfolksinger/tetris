module Tetris
  class Robot
    def self.decide( gameboard, current_piece )
      column_heights = gameboard.all_column_heights[ 0..(-current_piece.width ) ]
      chosen_index   = column_heights.index( column_heights.min )
    end
  end
end