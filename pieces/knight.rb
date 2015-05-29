require_relative '../piece'

class Knight < Piece

  attr_accessor :curr_pos
  attr_reader :color, :move_vector

  def initialize(args)
    @curr_pos = args[:curr_pos]
    @color = args[:color].to_sym
    @move_vector = [-17, -15, -10, -6, 6, 10, 15, 17]
  end

end