class BoardView

	def your_turn(color)
		puts "#{color}\'s turn."
	end

	def prompt_piece(color)
		print "#{color}, which piece would you like to move?\n"
	end

	def valid_moves(piece, valid)
		puts "Moves for #{piece.color}\'s #{piece.class} #{piece.curr_pos}: #{valid}."
	end

	def choose_your_own_color
		puts "Please choose a piece of your own color\n"
	end

	def please_select_a_piece
		puts "Please select a space that contains a piece.\n"
	end

	def select_valid_move
		puts "Please select a valid move from the list.\n"
	end

	def prompt_move(piece)
		print "#{piece.color} move #{piece.curr_pos} where? "
	end

	def valid_moves_are_empty
		puts "Please select a piece that has valid moves.\n"
		puts
	end

	def complete_move(piece, old_position)
		puts "Ok, #{piece.color}\'s #{piece.class} from #{old_position} to #{piece.curr_pos}."
	end

	def capture_msg(piece, capture)
		puts "Ok, #{piece.color}\'s #{piece.class} at #{piece.curr_pos} captures #{capture.color}\'s #{capture.class} at #{capture.curr_pos}"
	end

	# def check
	# 	puts "Your King's in check!"
	# end

	# def check_mate
	# 	puts "Checkmate!"
	# end

end

