class Position
	attr_accessor :board, :turn
	DIM = 3
	SIZE = DIM * 3
	def initialize(board = nil, turn="x")

		@board = board || %w[-]*SIZE
		@turn = turn
	end

	def move(index)
		temp = Position.new(@board.dup)
		
		temp.board[index] = @turn
		temp.turn = xturn
		# @board[index] = @turn
		# @turn = xturn 
		#puts @board #Function to change turn
		# return self
		return temp

	end

	# def possible_moves
	# 	count = 0
	# 	temp = []
	# 	@board.each do |val|
	# 		if val == "-"
	# 			temp<<count
	# 		end
	# 		count +=1
	# 	end
	# 	temp
	# end

	def possible_moves
		@board.map.with_index{|p,i| i if p == '-'}.compact
	end

	def win? turn
		rows = @board.each_slice(DIM).to_a
		rows.any?{|row| row.all?{|p| p==turn} } ||
		rows.transpose.any?{|col| col.all? {|c| c==turn} }||
		rows.map.with_index.all?{|row,i| row[i] == turn } ||
		rows.map.with_index.all?{|row,i| row[DIM-1-i] == turn }
	
	end
	def minimax(depth = 1)
		return 100 if win?"x"
		return -100 if win?"o"
		return 0 if possible_moves.empty?
		@@minmax ||={}
		value = @@minmax[@board]
		return value unless value.nil?
		@@minmax[@board] = possible_moves.map{|m| move(m).minimax(depth+1)}.send(ret_turn) - (@turn == "x" ? -depth :  depth)
	end

	def best_move
		possible_moves.send((@turn == "x"? :max_by : :min_by)){|m| move(m).minimax}
	end

	def xturn
		@turn == "x" ? "o" : "x"
	end
	def ret_turn
		@turn == "x"? :max : :min
	end
end 
