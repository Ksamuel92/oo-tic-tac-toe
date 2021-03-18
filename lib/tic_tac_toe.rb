class TicTacToe
    def initialize
      @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end
    #WIN_COMBINATIONS Constant keeps track of every possible combination of winning boards
    WIN_COMBINATIONS = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
  
    def display_board #This displays the board in a CLI manner
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
  
    def input_to_index(user_input) # This method coverts user_input to index by subtracting 1 from the input
      user_input.to_i - 1
    end
  
    def move(index, token) #This method takes in the index value and the token, and puts the token on the board
      @board[index] = token
    end
  
    def position_taken?(index) #This checks if the position is taken on the board by seeing if there is not our default " " placement
      @board[index] != " "
    end
  
    def valid_move?(index) #checks if its a valid move by checking if position_taken is false and the index is between 0 and 8
      !position_taken?(index) && index.between?(0,8)
    end
  
    def turn_count #Checks turn count by counting how many spaces do not have a blank. If there's two turns, that means two previously blank spaces are now taken.
      @board.count{|square| square != " " }
    end
  
    def current_player #Determines current player by basically assigning "X" to "even" turns and "O" to "odd" turns
      turn_count.even? ? "X" : "O"
    end
  
    def turn #This puts together many of the above methods to make a turn method. Grabs user_input, converts user_input to index. Checks for a valid move, and if so, Token is the current_player, and move takes in index and token
      puts "Please enter a number (1-9):"
      user_input = gets.strip
      index = input_to_index(user_input)
      if valid_move?(index)
        token = current_player
        move(index, token)
      else #If move is not valid, the method calls itself again and restarts
        turn
      end #after a valid move is made, it displays board.
      display_board
    end
  
    def won? #This checks if a player has won by iterating through the winning combinations and seeing if the first index contains a token. If so, it will check to see if that token is in the rest of that particular combination's spaces.
      WIN_COMBINATIONS.any? do |combo|
        if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
          return combo # If so, it will return the winning combo
        end
      end
    end
  
    def full? #Checks if board is full by seeing if every position does not equal " "
      @board.all?{|square| square != " " }
    end
  
    def draw? #Game is a draw if it's full and no one has won
      full? && !won?
    end
  
    def over? #game is over whether someone won or is a draw
      won? || draw?
    end
  
    def winner #if combo is equal to combo (essentiall), it will display the winner
      if combo = won?
        @board[combo[0]]
      end
    end
  
    def play #turn method until over is true #if winner is true, display congrats, otheriwse its a cat's game
      turn until over?
      puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end
  end