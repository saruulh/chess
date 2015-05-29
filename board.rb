require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'pieces/king'

class Board

  attr_accessor :board

  def initialize (white_King_pos = 4, black_King_pos = 60)
    @valid_moves = []
    @board = {
      0 => Rook.new(color: "w", curr_pos: 0),
      1 => Knight.new(color: "w", curr_pos: 1),
      2 => Bishop.new(color: "w", curr_pos: 2),
      3 => Queen.new(color: "w", curr_pos: 3),
      4 => King.new(color: "w", curr_pos: 4),
      5 => Bishop.new(color: "w", curr_pos: 5),
      6 => Knight.new(color: "w", curr_pos: 6),
      7 => Rook.new(color: "w", curr_pos: 7),
      8 => Pawn.new(color: "w", curr_pos: 8),
      9 => Pawn.new(color: "w", curr_pos: 9),
      10 => Pawn.new(color: "w", curr_pos: 10),
      11 => Pawn.new(color: "w", curr_pos: 11),
      12 => Pawn.new(color: "w", curr_pos: 12),
      13 => Pawn.new(color: "w", curr_pos: 13),
      14 => Pawn.new(color: "w", curr_pos: 14),
      15 => Pawn.new(color: "w", curr_pos: 15),

      16 => nil,
      17 => nil,
      18 => nil,
      19 => nil,
      20 => nil,
      21 => nil,
      22 => nil,
      23 => nil,
      24 => nil,
      25 => nil,
      26 => nil,
      27 => nil,
      28 => nil,
      29 => nil,
      30 => nil,
      31 => nil,
      32 => nil,
      33 => nil,
      34 => nil,
      35 => nil,
      36 => nil,
      37 => nil,
      38 => nil,
      39 => nil,
      40 => nil,
      41 => nil,
      42 => nil,
      43 => nil,
      44 => nil,
      45 => nil,
      46 => nil,
      47 => nil,


      48 => Pawn.new(color: "b", curr_pos: 48),
      49 => Pawn.new(color: "b", curr_pos: 49),
      50 => Pawn.new(color: "b", curr_pos: 50),
      51 => Pawn.new(color: "b", curr_pos: 51),
      52 => Pawn.new(color: "b", curr_pos: 52),
      53 => Pawn.new(color: "b", curr_pos: 53),
      54 => Pawn.new(color: "b", curr_pos: 54),
      55 => Pawn.new(color: "b", curr_pos: 55),
      56 => Rook.new(color: "b", curr_pos: 56),
      57 => Knight.new(color: "b", curr_pos: 57),
      58 => Bishop.new(color: "b", curr_pos: 58),
      59 => Queen.new(color: "b", curr_pos: 59),
      60 => King.new(color: "b", curr_pos: 60),
      61 => Bishop.new(color: "b", curr_pos: 61),
      62 => Knight.new(color: "b", curr_pos: 62),
      63 => Rook.new(color: "b", curr_pos: 63)
    }
  end

  def get_valid_moves(piece, delta)
    if piece.kind_of?(King) || piece.kind_of?(Knight)
      new_pos = piece.curr_pos + delta
      if (0..63).include?(new_pos)
        return new_pos if @board[new_pos].opponent?
        return if @board[new_pos].ally?
        return new_pos
      end
    elsif piece.kind_of?(Queen) || piece.kind_of?(Rook) || piece.kind_of?(Bishop)
      new_pos = piece.curr_pos + delta
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
    else
      new_pos = piece.curr_pos + delta
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
  end

  def valid_move_loop(piece)
    if piece.kind_of?(King) || piece.kind_of?(Knight)
      piece.move_vector.each do |delta|
        @valid_moves << get_valid_moves(piece)
      end
    elsif piece.kind_of?(Queen) || piece.kind_of?(Rook) || piece.kind_of?(Bishop)
      piece.move_vector.each do |delta|
        get_valid_moves(delta)
      end
    else
      move_vector = piece.getto move_vector
      move_vector.each do |delta|
        @valid_moves << get_valid_moves(delta)
      end
    end
  end

  def in_check?
    valid_moves = []
    @board.each do |position, piece|
      king_pos = piece.color == :w ? white_King_pos : black_King_pos
      if piece.opponent?
        valid_moves << piece.valid_move_loop
        board[king_pos].check = valid_moves.includes?(king_pos)
      end
    end
  end

  def to_s
    arr = []
    disp_arr = []
    @board.each do |position, piece|
      if piece
        arr << icon(piece)
      else
        arr << " "
      end
    end
    disp_arr = arr.each_slice(8).to_a.reverse
    8.times do |counter|
      print "#{(counter-8).abs} " + disp_arr[counter].join('  ') + "\n"
      counter -= 1
    end
    print "  a  b  c  d  e  f  g  h\n"
  end

  def icon(piece)
    icon = " "
    if piece.color == :w
      icon = "♔" if piece.kind_of?(King)
      icon = "♕" if piece.kind_of?(Queen)
      icon = "♗" if piece.kind_of?(Bishop)
      icon = "♖" if piece.kind_of?(Rook)
      icon = "♘" if piece.kind_of?(Knight)
      icon = "♙" if piece.kind_of?(Pawn)

    else
      icon = "♚" if piece.kind_of?(King)
      icon = "♛" if piece.kind_of?(Queen)
      icon = "♝" if piece.kind_of?(Bishop)
      icon = "♜" if piece.kind_of?(Rook)
      icon = "♞" if piece.kind_of?(Knight)
      icon = "♟" if piece.kind_of?(Pawn)
    end
    return icon
  end
end

b = Board.new
b.to_s
# pawn = b.board[15]
# b.board[15] = nil
# b.board[23] = pawn
# knight = b.board[57]
# b.board[57] = nil
# b.board[40] = knight
# b.to_s