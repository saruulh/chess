require_relative '../piece'
require_relative '../board'

class Queen < Piece

  attr_accessor :curr_pos
  attr_reader :color, :move_vector

  def initialize(args)
    @curr_pos = args[:curr_pos]
    @color = args[:color].to_sym
    @move_vector = [-9, -8, -7, -1, 1, 7, 8, 9]
  end

end