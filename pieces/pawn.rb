require_relative '../piece'
require_relative '../board'

class Pawn < Piece

  attr_accessor :curr_pos
  attr_reader :color

  def initialize(args)
    @curr_pos = args[:curr_pos]
    @color = args[:color].to_sym
    @board = args[:board]
    @valid_moves = []
  end

  def move_vector
    if @color == :w
      @move_vector = [7, 8, 9]
      @move_vector << 16 if (8..15).include?(@curr_pos)
    else
      @move_vector = [-9, -8, -7]
      @move_vector << -16 if (48..55).include?(@curr_pos)
    end
  end

  def get_valid_moves(delta)
    new_pos = @curr_pos + delta
    moving_forward = delta == 8 || delta == -8
    if (0..63).include?(new_pos)
      if moving_forward && (@board[new_pos].opponent? || @board[new_pos].ally?)
         return
      elsif @board[new_pos].opponent?
         return new_pos
      elsif @board[new_pos].ally?
        return
      elsif moving_forward
        return new_pos
      end
    end
  end

  def valid_move_loop
    move_vector
    @move_vector.each do |delta|
      @valid_moves << get_valid_moves(delta)
    end
  end

end

