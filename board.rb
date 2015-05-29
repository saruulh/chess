require_relative 'pieces' #update accordingly

class Board

  attr_accessor :board

  def initialize (white_King_pos = 4, black_King_pos = 60)
    @board = {
      0 => Rook.new(:w)
      1 => Knight.new(:w)
      2 => Bishop.new(:w)
      3 => Queen.new(:w)
      4 => King.new(:w)
      5 => Bishop.new(:w)
      6 => Knight.new(:w)
      7 => Rook.new(:w)
      8..15 => Pawn.new(:w)

      16..47 => nil

      48..55 => Pawn.new(:b)
      56 => Rook.new(:b)
      57 => Knight.new(:b)
      58 => Bishop.new(:b)
      59 => Queen.new(:b)
      60 => King.new(:b)
      61 => Bishop.new(:b)
      62 => Knight.new(:b)
      63 => Rook.new(:b)
    }
  end

  def in_check?
    valid_moves = []
    @board.each do |position, piece|
      if piece.opponent?
        valid_moves << piece.valid_move_loop
        board[king_pos].check =valid_moves.includes?(king_pos) #verify the color of king
  end
end