class BoardView

	def your_turn(color)
		puts "#{color}\'s turn."
	end

	def prompt_piece(color)
		print "#{color}, which piece would you like to move?\n"
	end

	def valid_moves(piece, valid)
		puts "Moves for #{piece.color} #{piece.class} #{piece.position}: #{valid}."
	end

	def prompt_move(piece, move)
		print "Where would you like to move #{piece.color} #{piece.class}?"
	end

	def complete_move(piece, old_position)
		puts "Ok, #{piece.color}\'s #{piece.class} from #{old_position} to #{piece.position}."
	end

	def capture_msg(piece, capture)
		puts "Ok, #{piece.color}\'s #{piece.class} at #{piece.position} captures #{capture.color}\'s #{capture.class} at #{capture.position}"
	end

	# def check
	# 	puts "Your King's in check!"
	# end

	# def check_mate
	# 	puts "Checkmate!"
	# end

end

