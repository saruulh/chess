class Piece

	attr_accessor :color, :position

  def initialize
  	@color = color
  	@position = position
  end

  def white
  	@color = :w
  end

  def white?
  	@color == :w
  end

  def black
  	@color = :b
  end

  def black?
  	@color == :b
  end

  def oppposite_color
  	white? ? black : white
  end

  def opponent?(piece)
  	piece.kind_of?(piece) && piece.color == oppposite_color
  end

  def ally?(piece)
  	piece.kind_of?(piece) && piece.color == color
  end

end

w = Piece.new
p w.white
p w.white?
p w.oppposite_color
# p w.opponent?()
# p w.ally?()

p '--------'
b = Piece.new
p b.black
p b.black?
p b.oppposite_color
# p b.opponent?()
# p b.ally?()

