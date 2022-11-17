# class:
# tictactoe board
# game

class Tictactoe

    @@player_one_tally = 0
    @@player_two_tally = 0
    @@total_tally = 0

    def initialize
        @board = Array.new(3) { Array.new(3, ' ') }
    end

    def printboard
        for i in 0..@board.length-1
            for x in 0..@board[0].length-1
                if x == 1
                    print ' | ' + @board[i][x] + ' | '
                else
                    print @board[i][x]
                end
            end
            if i != 2
                puts ''
                puts "----------"
            end
        end
    end

    def updateboard(input, location)
        row = location[0].to_i
        col = location[1].to_i
        @board[row][col] = input
        @@total_tally += 1
        if @@total_tally %2 == 0
            @@player_two_tally += 1
        else
            @@player_one_tally += 1
        end
    end

    def checkgame
        winnerbool = false
        winner = [' ',winnerbool]
        # straight line win conditions
        @board.each {|col|
            if col == ["X","X","X"] || col == ["O","O","O"]
                winner.unshift(col[0])
                winnerbool = true
            end    
        }

        for i in 0..@board.length-1
            if @board[0][i] == @board[1][i] && @board[0][i] == @board[2][i] && @board[0][i] != " "
                winner.unshift(@board[0][1])
                winnerbool = true
            end
        end   
    
        
        # diagonal win conditions
        if @board[0][0] == @board[1][1] && @board[0][0] == @board[2][2] && @board[0][0] != " "
            winner.unshift(@board[0][0])
            winnerbool = true
        elsif @board[0][2] == @board[1][1] && @board[0][2] == @board[2][0] && @board[0][2] != " "
            winner.unshift(@board[0][2])
            winnerbool = true            
        end

        # tie condition
        if @@total_tally == 9 && winnerbool == false
            winner.unshift('tie')
            winnerbool = true
        end

        if winnerbool == true
            winner[1] = true
        end

        winner
    end

    def findempty
        emptytiles = []
        arrIndex = 0

        @board.each_with_index{|col, colindex| 
            col.each_with_index{|tile, rowindex|
                if tile == ' '
                    emptytiles[arrIndex] = [colindex, rowindex]
                    arrIndex += 1
                end
            }
        }

        emptytiles
    end

    def getchoice
        available = findempty
        # figure out how to gather row/col input into an array to be returned
        if @@total_tally == 0
            puts "X goes first, these are the available tiles: #{available}"
            puts "Which row would you like to select?"
            choice1 = gets.strip
            puts "which column would you like to select?"
            choice2 = gets.strip
        elsif @@total_tally %2 != 0
            puts "It is Player two's turn, where would you like to place your O?: #{available}"
            puts "Which row would you like to select?"
            choice1 = gets.strip
            puts "which column would you like to select?"
            choice2 = gets.strip
        elsif @@total_tally %2 == 0
            puts "It is Player one's turn, where would you like to place your X?: #{available}"
            puts "Which row would you like to select?"
            choice1 = gets.strip
            puts "which column would you like to select?"
            choice2 = gets.strip
        end

        temp1 = choice1
        temp2 = choice2
        temp1 = temp1.to_i
        temp2 = temp2.to_i

        testbool = available.include?([temp1,temp2])

        if testbool == false 
            puts "That tile is not available! Please try again."
            getchoice
        else
            choice = [choice1,choice2]
            choice
        end
    end

    def checktally 
        tally = @@total_tally
    end


end


# methods:
# play the game
# update the board
# display the board
# check for win/tie



# prompt the user for their input

# update the board based on user input

# check for win/tie

# display board

# prompt next user
 
# repeat

def playgame()
    puts "Welcome to TicTacToe!"
    game = Tictactoe.new()
    puts "This is your starting board: "
    game.printboard
    puts ''
    while game.checkgame[1] == false
        tally = game.checktally
        if tally %2 != 0
            symbol = "O"
        else
            symbol = "X"
        end
        game.updateboard(symbol,game.getchoice)
        game.printboard
        puts ''
    end
    winner = game.checkgame
    puts "The winner is: #{winner[0]}"
end

playgame
