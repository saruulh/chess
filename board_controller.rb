require_relative 'board'
require_relative 'board_view'
# require_relative 'piece'

class BoardController

  def initialize
    @view = BoardView.new
    @board = Board.new
  end

  def run

  end

end
