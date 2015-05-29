require_relative '../piece'

class Rook < Piece

  attr_accessor :curr_pos
  attr_reader :color

  def initialize(args)
    @curr_pos = args[:curr_pos]
    @color = args[:color].to_sym
    @move_vector = [-8, -1, 1, 8]
  end

end
