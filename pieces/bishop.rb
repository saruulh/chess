require_relative '../piece'

class Bishop < Piece

  attr_accessor :curr_pos
  attr_reader :color, :move_vector

  def initialize(args)
    @curr_pos = args[:curr_pos]
    @color = args[:color].to_sym
    @move_vector = [-9, -7, 7, 9]
  end

end