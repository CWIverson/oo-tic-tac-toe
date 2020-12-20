require 'pry'
class TicTacToe
    WIN_COMBINATIONS=[
        [0,1,2],[0,3,6],[0,4,8],
        [3,4,5],[1,4,7],[2,4,6],
        [6,7,8],[2,5,8]
    ]
    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
        @winner_token = " "
    end
    def board=(board)
        @board=board
        binding.pry
    end
    def board 
        @board
    end
    
    def display_board
        print " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        print "-----------"
        print " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        print "-----------"
        print " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
    def input_to_index(input)
        num_input = input.to_i
        index = (num_input - 1)
        
        index
    end
    def move(spot, player)
         @board[spot]=player
    end
    def position_taken?(index)
        if @board[index] == " "
            false
        else
            true
        end
    end
    def valid_move?(index)
       taken = self.position_taken?(index)
        if index>=0 && index<8 && (taken==false)
            true
        else
            false     
        end
    end
    def turn_count
        i=0
        turns=0
        while i<@board.length
            taken = self.position_taken?(i)
            if taken == true
                turns += 1
                i+=1
            else
                i+=1
            end
        end
        turns
    end
    def current_player
        count =self.turn_count
        if count == 0
            "X"
        elsif count.even?
            "X"
        else
            "O"
        end
    end
    def turn
        input= gets.chomp
        input_index=self.input_to_index(input)
        player=self.current_player
        if self.valid_move?(input_index)
            self.move(input_index,player)
            self.display_board
        else
            puts "invalid"
            input=gets.chomp
        end
    end
    def won?
        win=()
        WIN_COMBINATIONS.each do |winner|
            win_index_1=winner[0]
            win_index_2=winner[1]
            win_index_3=winner[2]

            position_1 = @board[win_index_1]
            position_2 = @board[win_index_2]
            position_3 = @board[win_index_3]
           
            if position_1 == position_2 && position_2 == position_3 && self.position_taken?(win_index_1)
                win=true
                winner_declared = [win_index_1, win_index_2, win_index_3]
                @winner_token = position_1
                return winner_declared
            else
                win=false
            end
        end
        win
    end
    def full?
       if @board.include?(" ")
        false
       else
        true
       end
    end
    def draw?
        if !(self.full?)
            false
        elsif self.won?
            false
        else
            true
        end
    end
    def over?
        if self.won?
            true
        elsif self.draw?
            true
        else
            false
        end
    end
    def winner 
        if self.won?
            @winner_token
        end
    end
    def play
        while self.over? == false
        self.turn
        end
        if self.won?
            puts "Congratulations #{self.winner}!"
        elsif self.draw?
            puts "Cat's Game!"
        end
        
            
        
    end

end