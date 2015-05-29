require_relative '../piece'
require_relative '../board'

class Knight < Piece

  attr_accessor :curr_pos
  attr_reader :color

  def initialize(args)
    @curr_pos = args[:curr_pos]
    @color = args[:color].to_sym
    @board = args[:board]
    @valid_moves = []
    @move_vector = [-17, -15, -10, -6, 6, 10, 15, 17]
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