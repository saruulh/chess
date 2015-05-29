require_relative '../piece'
require_relative '../board'

class King < Piece

  def initialize(args)
    @curr_pos = args[:curr_pos]
    @color = args[:color].to_sym
    @board = args[:board]
    @valid_moves = []
    @move_vector = [-9, -8, -7, -1, 1, 7, 8, 9]
  end


  def get_valid_moves(delta)
    new_pos = @curr_pos + delta
    if (0..63).include?(new_pos)
      return new_pos if @board[new_pos].opponent?
      return if @board[new_pos].ally?
      return new_pos
    end
  end

  def valid_move_loop
    @move_vector.each do |delta|
      @valid_moves = get_valid_moves(delta)
    end
  end

end