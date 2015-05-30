require_relative '../piece'

class Pawn < Piece

  attr_accessor :curr_pos
  attr_reader :color, :move_vector

  def initialize(args)
    @curr_pos = args[:curr_pos]
    @color = args[:color].to_sym
  end

  def get_move_vector
    if @color == :white
      @move_vector = [7, 8, 9]
      @move_vector << 16 if (8..15).include?(@curr_pos)
    else
      @move_vector = [-9, -8, -7]
      @move_vector << -16 if (48..55).include?(@curr_pos)
    end
  end

end



