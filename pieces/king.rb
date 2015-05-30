require_relative '../piece'

class King < Piece

  attr_accessor :curr_pos, :check
  attr_reader :color, :move_vector

  def initialize(args)
    @curr_pos = args[:curr_pos]
    @color = args[:color].to_sym
    @check = false
    @move_vector = [-9, -8, -7, -1, 1, 7, 8, 9]
  end

end
