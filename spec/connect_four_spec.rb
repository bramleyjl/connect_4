require_relative "../lib/connect_four"
	describe Board do
		let(:board) {Board.new}

		describe "#initialize" do
			it "generates a new board" do
				expect(board.squares.size).to eq(42)
				expect(board.squares[[0,2]]).to eq("\u{2622} ")
			end
		end

	end

	describe Player do
		describe "#initialize" do
			let(:player1) {Player.new("\u{262E}", 'peace')}

			it "initializes a player with a symbol and a name" do
				expect(player1.symbol).to eq("\u{262E}")
				expect(player1.name).to eq('peace')
			end
		end
	end

	describe Game do
		let(:game) {Game.new(["John", "Peggy"])}

		describe "#initialize" do
			it "initializes a new board" do
				expect(game.board).to be
			end

			it "initializes new players" do
				expect(game.players).to be
			end
		end
		
		describe "#randomize_players" do
		    it "sets player1 and player2 randomly" do
		      expect(game.player1.name).to eq("John").or eq("Peggy")
				  expect(game.player2.name).to eq("John").or eq("Peggy")
				end
		end

		describe "#play" do
			
		end

		describe "#move_select" do
			context "chosen column is empty" do

				before do 
					game.move_select(3)
				end

				it "changes [3, 0] to current player's symbol" do
					expect(game.board.squares[[3, 0]]).to eq(game.player1.symbol)
				end
			end
		end
		
		describe "#check_height" do
		  context "chosen column is empty" do
		    it "places tile on '0'" do
		      expect(game.check_height(3)).to eq(0)
		    end
		    
		  context "chosen column is neither empty nor full" do
		      before do
		       game.board.squares[[4,0]] = "⚪ "
		       game.board.squares[[4,1]] = "⚪ "
		       game.board.squares[[4,2]] = "⏺ "
		      end
		      
		      it "places tile at the correct height" do
		        expect(game.check_height(4)).to eq(3)
		      end
		    end
		    					
		  context "chosen column is full" do
		      before do
		        game.board.squares[[5,0]] = "⏺ "
		        game.board.squares[[5,1]] = "⏺ "
		        game.board.squares[[5,2]] = "⚪ "
		        game.board.squares[[5,3]] = "⏺ "
		        game.board.squares[[5,4]] = "⏺ "
		        game.board.squares[[5,5]] = "⚪ "
		      end
		      
		      it "returns a y value of '6'" do
		        expect(game.check_height(5)).to eq(6)
		      end
		    end
		  end
		end

		descirbe "#winner" do

		end			

	end