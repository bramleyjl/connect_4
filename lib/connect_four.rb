class Board
	attr_accessor :squares

	def initialize
		@squares = Hash.new
		generate_squares
	end

	def generate_squares
		for x in 0..6
			for y in 0..5
				coord = [x, y]
				@squares[coord] = "☢ "
			end
		end
	end

	def display
		5.downto(0) do |y|
			print (y).to_s
			for x in 0..6
				print " " + @squares[[x, y]]
			end
			print "#{y}\n"
		end
		print "  0  1  2  3  4  5  6\n"
	end
end

class Player
	attr_accessor :symbol, :name

	def initialize(symbol, name)
		@symbol = symbol
		@name = name
	end
end

class Game
	attr_accessor :players, :player1, :player2, :board, :current_player

	def initialize
		@board = Board.new
    print "Welcome to Connect Four! Type in the two players' names.\n"
	end

  def start(playerOne = $stdin.gets.chomp, playerTwo = $stdin.gets.chomp)
    @players = Array.new
    @players << playerOne
    @players << playerTwo
    randomize_players
  end
	
  def randomize_players
	  @player1 = Player.new("⚪ ", @players.sample)  
	  @players.delete_if { |n| n == @player1.name }
	  @player2 = Player.new("⏺ ", @players[0])
	  @current_player = @player1
    print "#{@player1.name} is ⚪ and goes first. #{@player2.name} is ⏺ and goes second.\n"
  end

	def play
		until @winner == true
      @board.display
      print "Current turn: #{current_player.name}(#{current_player.symbol}) -- "
      move_select()	
		end
	end

	def move_select(input = gets.chomp.to_i)
	  x_coord = input
	  y_coord = check_height(x_coord)
	  if y_coord < 6
	    @board.squares[[x_coord, y_coord]] = @current_player.symbol
      victory_check
      player_swap
	    play
	  else
	    puts "That column is full. Please choose another one."
	    play
	  end
	end

  def check_height(x_coord)
    y = 0
    until @board.squares[[x_coord, y]] == "☢ " or y == 6
      y += 1
    end
    y
  end 
   
  def player_swap
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end 

  def victory_check
    #horizontal check
    for i in (0..5)
      connection = 0
      for n in (0..6)
        if @board.squares[[n, i]] == @current_player.symbol
          connection += 1
        else 
          connection = 0
        end
        game_over if connection == 4
      end
    end

    #vertical check
    for i in (0..6)
      connection = 0
      for n in (0..5)
        if @board.squares[[i, n]] == @current_player.symbol
          connection += 1
        else 
          connection = 0
        end
        game_over if connection == 4
      end
    end

    #right diagonal check
    for i in (0..3)
      for n in (0..2)
        if @board.squares[[i, n]] == @current_player.symbol &&
          @board.squares[[i + 1, n + 1]] == @current_player.symbol &&
          @board.squares[[i + 2, n + 2]] == @current_player.symbol &&
          @board.squares[[i + 3, n + 3]] == @current_player.symbol
          game_over
        end
      end
    end
    
    #left diagonalcheck
    for i in (3..6)
      for n in (0..2)
        if @board.squares[[i, n]] == @current_player.symbol &&
          @board.squares[[i - 1, n + 1]] == @current_player.symbol &&
          @board.squares[[i - 2, n + 2]] == @current_player.symbol &&
          @board.squares[[i - 3, n + 3]] == @current_player.symbol
          game_over
        end
      end
    end
    return false
  end

  def game_over
    @winner = true
    @board.display
    p "Game Over! #{@current_player.name} (#{@current_player.symbol}) is the winner!"
  end
	
end

#game = Game.new
#game.start
#game.play