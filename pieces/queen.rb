require_relative '../piece'
require_relative '../board'

class Queen < Piece

  attr_accessor :curr_pos
  attr_reader :color

  def initialize(args)
    @curr_pos = args[:curr_pos]
    @color = args[:color].to_sym
    @board = args[:board]
    @valid_moves = []
    @move_vector = [-9, -8, -7, -1, 1, 7, 8, 9]
  end


  def get_valid_moves(delta)
    new_pos = @curr_pos + delta
    7.times do
      if (0..63).include?(new_pos)
        if @board[new_pos].opponent?
          @valid_moves << new_pos
          break
        elsif @board[new_pos].ally?
          break
        else
          @valid_moves << new_pos
        end
        new_pos += delta
      end
    end
  end

  def valid_move_loop
    @move_vector.each do |delta|
      get_valid_moves(delta)
    end
  end

end