require_relative 'board'
require_relative 'board_viewer'
require_relative 'pieces/king'
# require_relative 'piece'

class BoardController

  def initialize
    @view = BoardView.new
    @board = Board.new

  end

  def run
    no_checkmate = true
    while (no_checkmate)
      @board.to_s
      @view.your_turn(@board.whose_turn)

      king_still_in_check = true

      while (king_still_in_check)
        @board.valid_moves = []
        valid_moves_empty = true
        while (valid_moves_empty)
          @view.prompt_piece(@board.whose_turn)
          pos = gets.chomp.to_i
          while @board.board[pos] && @board.board[pos].color != @board.whose_turn
            @view.choose_your_own_color
            pos = gets.chomp.to_i
          end
          piece = @board.board[pos]
          @board.valid_move_loop(piece)
          valid_moves = @board.valid_moves
          if piece.nil?
            @view.please_select_a_piece
          else
            @view.valid_moves(piece, valid_moves)
          end
          valid_moves_empty = valid_moves.empty?
          if valid_moves_empty
            @view.valid_moves_are_empty
          end
        end

        @view.prompt_move(piece)
        next_pos = gets.chomp.to_i
        until (valid_moves.include?(next_pos)) do
          @view.select_valid_move
        end
        if valid_moves.include?(next_pos)
          @board.board[pos] = nil
          capture = @board.board[next_pos]
          @board.board[next_pos] = piece
          piece.curr_pos = next_pos

          @board.king_pos[piece.color] = next_pos if piece.kind_of?(King)

          ##### IS KING STILL IN CHECK -- LOOP THROUGH OPPONENT PIECES
          king_still_in_check = @board.in_check?
          if king_still_in_check
            # UNDO EVERYTHING AND REPEAT
            piece.curr_pos = pos
            if capture
              @board.board[next_pos] = capture
            else
              @board.board[next_pos] = nil
            end
            @board.board[pos] = piece
            @view.check_msg(piece.color)
          else
            break
          end
        end
      end
      if capture
        @view.capture_msg(piece, capture)
        @board.captured << capture
      else
        @view.complete_move(piece, pos)
      end

      opposite_color = @board.whose_turn == :white ? :black : :white
      @board.valid_move_loop(piece)
      valid_moves = @board.valid_moves
      if valid_moves.include?(@board.king_pos[opposite_color])
        # CHECK
        @board.board[@board.king_pos[opposite_color]].check = true
        @view.check_msg(opposite_color)
      end
      @board.valid_moves = []
      @board.whose_turn = @board.whose_turn == :white ? :black : :white
    end
  end
end

bc = BoardController.new
bc.run
