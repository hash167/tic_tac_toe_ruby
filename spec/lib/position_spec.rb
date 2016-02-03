require "position"

describe Position do
	context('#new') do
		it "is going to initialize a new board" do
			position = Position.new
			expect(position.board).to eq(%w[-]*9) 
			expect(position.turn).to eq("x")
		end

		it "is is going to inititalize a position given a board and turn" do |variable|
			position = Position.new( %w[x - - - - - - o -], "o")
			expect(position.board).to eq(%w[x - - - - - - o -]) 
			expect(position.turn).to eq("o")
		end
	end

	context('#move') do
		it "will make a move" do
		
			position = Position.new.move(0)
			expect(position.board).to eq(%w[x - - - - - - - -])
			expect(position.turn).to eq("o")
		end
		
	end

	context('#possible_moves') do
		it "get posible moves" do

			position = Position.new.move(0).move(1)
			expect(position.possible_moves).to eq([2,3,4,5,6,7,8])

		end
	end

	context('#win?') do 
		it { expect(Position.new.win?("x")).to be_falsy}
		it { expect(Position.new(%w(x x x
                                - - -
                                - - -)).win?("x")).to be_truthy  }
    it { expect(Position.new(%w(- - -
                                x x x
                                - - -)).win?("x")).to be_truthy  }
    it { expect(Position.new(%w(- - -
                                - - -
                                x x x)).win?("x")).to be_truthy  }
    it { expect(Position.new(%w(o - -
                                o - -
                                o - -)).win?("o")).to be_truthy  }
    it { expect(Position.new(%w(- o -
                                - o -
                                - o -)).win?("o")).to be_truthy  }
    it { expect(Position.new(%w(- - o
                                - - o
                                - - o)).win?("o")).to be_truthy  }
    it { expect(Position.new(%w(o - -
                                - o -
                                - - o)).win?("o")).to be_truthy  }
    it { expect(Position.new(%w(- - o
                                - o -
                                o - -)).win?("o")).to be_truthy  }
	end

	context "#minimax" do
		it { expect(Position.new(%w[x x x - - - - - -], "x").minimax).to eq(100) }
		it { expect(Position.new(%w[o o o - - - - - -], "o").minimax).to eq(-100) }
		it { expect(Position.new(%w(x o x x o x o x o), "o").minimax).to eq(0) }
	    it { expect(Position.new(%w(x x - - - - - - -), "x").minimax).to eq(99) }
	    it { expect(Position.new(%w(o o - - - - - - -), "o").minimax).to eq(-99) }
	     it { expect{ timeout(2) { Position.new.minimax }}.not_to raise_error  }
	end

	context "#best_move" do
		it { expect(Position.new(%w(x x - - - - - - -), "x").best_move).to eq(2)}
		it { expect(Position.new(%w(o o - - - - - - -), "o").best_move).to eq(2) }
	end
	
end