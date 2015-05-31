require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'pieces/king'

class Board

  attr_accessor :board, :whose_turn, :valid_moves, :white_king_pos, :black_king_pos, :captured, :king_pos

  def initialize (white_king_pos = 4, black_king_pos = 60)
    @valid_moves = []
    @whose_turn = :white
    @king_pos = { white: 4, black: 60 }
    @captured = []
    @board = {
      0 => Rook.new(color: "white", curr_pos: 0),
      1 => Knight.new(color: "white", curr_pos: 1),
      2 => Bishop.new(color: "white", curr_pos: 2),
      3 => Queen.new(color: "white", curr_pos: 3),
      4 => King.new(color: "white", curr_pos: 4),
      5 => Bishop.new(color: "white", curr_pos: 5),
      6 => Knight.new(color: "white", curr_pos: 6),
      7 => Rook.new(color: "white", curr_pos: 7),
      8 => Pawn.new(color: "white", curr_pos: 8),
      9 => Pawn.new(color: "white", curr_pos: 9),
      10 => Pawn.new(color: "white", curr_pos: 10),
      11 => Pawn.new(color: "white", curr_pos: 11),
      12 => Pawn.new(color: "white", curr_pos: 12),
      13 => Pawn.new(color: "white", curr_pos: 13),
      14 => Pawn.new(color: "white", curr_pos: 14),
      15 => Pawn.new(color: "white", curr_pos: 15),

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


      48 => Pawn.new(color: "black", curr_pos: 48),
      49 => Pawn.new(color: "black", curr_pos: 49),
      50 => Pawn.new(color: "black", curr_pos: 50),
      51 => Pawn.new(color: "black", curr_pos: 51),
      52 => Pawn.new(color: "black", curr_pos: 52),
      53 => Pawn.new(color: "black", curr_pos: 53),
      54 => Pawn.new(color: "black", curr_pos: 54),
      55 => Pawn.new(color: "black", curr_pos: 55),
      56 => Rook.new(color: "black", curr_pos: 56),
      57 => Knight.new(color: "black", curr_pos: 57),
      58 => Bishop.new(color: "black", curr_pos: 58),
      59 => Queen.new(color: "black", curr_pos: 59),
      60 => King.new(color: "black", curr_pos: 60),
      61 => Bishop.new(color: "black", curr_pos: 61),
      62 => Knight.new(color: "black", curr_pos: 62),
      63 => Rook.new(color: "black", curr_pos: 63)
    }
  end

  def valid_move_loop(piece)
    unless piece.nil?
      if piece.kind_of?(Pawn)
        if (8..15).include?(piece.curr_pos) && piece.color == :white ||
          (48..55).include?(piece.curr_pos) && piece.color == :black
          move_vector = piece.get_move_vector
          move_vector -= piece.color == :white && @board[piece.curr_pos + 8] && @board[piece.curr_pos + 8].color == :white ? [16] : [0]
          move_vector -= piece.color == :black && @board[piece.curr_pos - 8] && @board[piece.curr_pos - 8].color == :black ? [-16] : [0]
        else
          move_vector = piece.move_vector
          move_vector -= piece.color == :white ? [16] : [-16]
        end
        move_vector.each do |delta|
          get_valid_moves(piece, delta)
        end
      else
        piece.move_vector.each do |delta|
          get_valid_moves(piece, delta)
        end
      end
    end
  end

  def in_check?
    @valid_moves = []
    color_to_check = @whose_turn == :white ? :black : :white
    king_pos = @king_pos[@whose_turn]
    @board.each do |position, piece|
      if piece && (piece.color == color_to_check)
        valid_move_loop(piece)
        return true if @valid_moves.include?(king_pos)
      end
    end
    return false
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
    mult = 7
    8.times do |counter|
      print "#{8 * mult}  " + disp_arr[counter].join('  ') + "\n"
      counter -= 1
      mult -= 1
    end
    print "   0  1  2  3  4  5  6  7\n"
  end

  private

  def get_valid_moves(piece, delta)
    if piece.kind_of?(King) || piece.kind_of?(Knight)
      return if piece.curr_pos % 8 == 0 && (delta == 15 || delta == -17 || delta == -9 || delta == -1 || delta == 7)
      return if piece.curr_pos % 8 == 1 && (delta == 6 || delta == -10)
      return if piece.curr_pos % 8 == 6 && (delta == -6 || delta == 10)
      return if piece.curr_pos % 8 == 7 && (delta == -15 || delta == 17 || delta == -7 || delta == 1 || delta == 9)

      new_pos = piece.curr_pos + delta
      if (0..63).include?(new_pos)
        if @board[new_pos] && @board[new_pos].opponent?(piece)
          @valid_moves << new_pos
        elsif @board[new_pos] && @board[new_pos].ally?(piece)
          return
        else #empty
          @valid_moves << new_pos
        end
      end
    elsif piece.kind_of?(Queen) || piece.kind_of?(Rook) || piece.kind_of?(Bishop)
      return if piece.curr_pos % 8 == 0 && (delta == -9 || delta == -1 || delta == 7)
      return if piece.curr_pos % 8 == 7 && (delta == -7 || delta == 1 || delta == 9)
      new_pos = piece.curr_pos + delta
      7.times do

        left_side = new_pos % 8 == 0 && (delta == -9 || delta == -1 || delta == 7)
        right_side = new_pos % 8 == 7 && (delta == -7 || delta == 1 || delta == 9)

        if (0..63).include?(new_pos)
          if @board[new_pos] && @board[new_pos].opponent?(piece)
            @valid_moves << new_pos
            break
          elsif @board[new_pos] && @board[new_pos].ally?(piece)
            break
          else
            @valid_moves << new_pos
          end
          if left_side || right_side
            break
          end
          new_pos += delta
        end
      end
    else    # PAWN LOGIC
      return if piece.curr_pos % 8 == 0 && (delta == -9 || delta == 7)
      return if piece.curr_pos % 8 == 7 && (delta == -7 || delta == 9)
      new_pos = piece.curr_pos + delta
      moving_forward = delta == 8 || delta == -8 || delta == 16 || delta == -16
      if (0..63).include?(new_pos)
        if moving_forward && @board[new_pos].nil?
          @valid_moves << new_pos
        elsif !moving_forward && @board[new_pos].nil?
          return
        elsif moving_forward && (@board[new_pos].opponent?(piece) || @board[new_pos].ally?(piece))
          return
        elsif @board[new_pos].opponent?(piece)
          @valid_moves << new_pos
        elsif @board[new_pos].ally?(piece)
          return
        elsif moving_forward
          @valid_moves << new_pos
        end
      end
    end
  end

  def icon(piece)
    icon = " "
    if piece.color == :white
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

# b = Board.new
# b.to_s
# pawn = b.board[15]
# b.board[15] = nil
# b.board[23] = pawn
# knight = b.board[57]
# b.board[57] = nil
# b.board[40] = knight
# b.to_s