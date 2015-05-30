require_relative 'board'
require_relative 'board_viewer'
# require_relative 'piece'

class BoardController

  def initialize
    @view = BoardView.new
    @board = Board.new
  end

  def run
    @view.your_turn(@board.whose_turn)
    @view.prompt_piece(@board.whose_turn)
    pos = gets.chomp.to_i
    piece = @board.board[pos]
    @board.valid_move_loop(piece)
    valid_moves = @board.valid_moves
    @view.valid_moves(piece, valid_moves)

  end

end

bc = BoardController.new
bc.run
