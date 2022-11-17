class ConnectFour

    attr_accessor :board, :row_array, :turn_tally

    def initialize
        @board = Array.new(6) {Array.new(7, '   ')}
        @row_array = Array.new(7,5)
        @turn_tally = 0
    end

    def get_input(symbol, choice = gets.strip) 
        
        choice = choice.to_i

        if choice.is_a?(Integer) == false || choice > 7 || choice < 1
            puts "Please input a number between 1 and 7"
            self.get_input(symbol)
        elsif @row_array[choice] == 0
            puts "That column is full!"
            self.get_input(symbol)
        else
            choice -= 1
            row = @row_array[choice]
            @row_array[choice] -= 1
        end
        
        @board[row][choice] = symbol
        choice
    end

    def printboard
        for i in 0..@board.length-1
            puts ''
            puts "-----------------------------"
            for x in 0..@board[0].length-1
                print "|"
                print @board[i][x]
            end
            print "|"
        end
        puts ""
        puts "-----------------------------"
    end

    def check_line(location,symbol)
        win = false
        repeat_count = 0
        @board[location].each_with_index do |letter, index|
            if repeat_count >= 4
                win = true
                break
            end
            if letter == symbol
                repeat_count += 1
            else
                repeat_count = 0
            end
        end
        win
    end

    def check_diagonal(location, symbol)
        y = location[0]
        x = location[1]
        repeat_count = 0

        until y == 5 || x == 0
            y += 1
            x -= 1
        end

        until y == 0 || x == 6
            if repeat_count == 4
                return true
            end

            if @board[y][x] == symbol
                repeat_count += 1
            else
                repeat_count = 0
            end
            
            y -= 1
            x += 1
        end

        until y == 0 || x == 6
            y -= 1
            x += 1
        end

        repeat_count = 0

        until y == 5 || x == 0
            if repeat_count == 4
                return true
            end

            if @board[y][x] == symbol
                repeat_count += 1
            else
                repeat_count = 0
            end
            
            y += 1
            x -= 1
        end

        false
    end

    def check_vertical(location, symbol)
        y = location[0]
        x = location[1]
        repeat_count = 0
        win = false

        until y > 5

            if @board[y][x] == symbol
                repeat_count += 1
            else
                repeat_count = 0
            end
            
            y += 1

            if repeat_count == 4
                win = true
            end
            
        end

        win
    end

    def play_game
        win = false
        x = " X "
        o = " O "


        while win == false
            if @turn_tally == 0
                self.printboard
                puts "Player one goes first, their symbol is X"
                puts "Which column between 1 and 7 would you like to select?"
                turn = x
                column = get_input(x)
            end

            if @turn_tally%2 == 0
                self.printboard
                puts "It is Player two's turn, their symbol is O"
                puts "Which column between 1 and 7 would you like to select?"
                turn = o
                column = get_input(o)
            else
                self.printboard
                puts "It is Player one's turn, their symbol is X"
                puts "Which column between 1 and 7 would you like to select?"
                turn = x
                column = get_input(x)
            end

            row = @row_array[column]+1

            @turn_tally += 1

            p "Row: #{row}"
            p "Col: #{column}"

            if self.check_vertical([row,column],turn) == true || self.check_diagonal([row,column],turn) == true || self.check_line(row,turn) == true
                p "check"
                win = true
            elsif @turn_tally == 42
                win = nil
            end
        end
    end

end

game = ConnectFour.new()

game.play_game
