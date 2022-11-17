class Mastermind

    def initialize
        @colours = ["blue","red","yellow","green","purple","orange"]
        @playerCurGuess = []
        @computerCurGuess = []
        @guesstally = 0
        @correctindices = []
        @halfcorrect = []
    end

    def randomselect
        # randomly select 4 of the 6 colours
        @codeArray = []
        for i in 0..3
            @codeArray.push(@colours[rand(5)])
        end
        @codeArray
    end

    def checkcolour(guess)
        # check if guessed colour is in the code
        if @codeArray.include?(guess)
            colour = true
        else
            colour = false
        end
        colour
    end

    def checklocation(guess,index)
        # check if guessed colour is in the right location and colour
        if guess == @codeArray[index]
            location = true
        else
            location = false
        end
        location
    end

    def playerguess
        # collect the players guess
        guessArray = []
        puts "These are your available colours: #{@colours}"
        if @guesstally == 0
            for i in 1..4
                puts "What colour would you like to place in slot #{i}?"
                guess = gets.strip
                guessArray.push(guess)
            end    
        else
            puts "This was your last guess: #{@playerCurGuess}"
            for i in 1..4
                puts "What colour would you like to place in slot #{i}?"
                guess = gets.strip
                guessArray.push(guess)
            end   
        end
        @guesstally += 1
        guessArray
    end

    def checkguess(guess)
        guess.each_with_index{|colour, index|
            # if this index is already correctly guessed, skip
            if @correctindices.include?(index) == true    
            # check if location and colour is correct
            elsif checklocation(colour, index) == true && @correctindices.include?(index) == false
                # add colour and details to player array, and just colour to computer array
                @playerCurGuess[index] = [colour,"Correct Spot + Colour"]
                @computerCurGuess[index] = colour
                @codeArray[index] = "nil"
                @correctindices.push(index)
                # if this colour was previously half correct, delete from half correct array
                if @halfcorrect.include?(colour)
                    @halfcorrect.delete(colour)
                end
            # if its half correct, add colour + details to player array, or just colour to half correct computer array
            elsif checkcolour(colour) == true && checklocation(colour, index) == false && @correctindices.include?(index) == false
                @playerCurGuess[index] = [colour,"Correct colour + wrong spot"]
                if @halfcorrect.include?(colour) == false
                    @halfcorrect.push(colour)
                end
            else
                @playerCurGuess[index] = [colour,"Incorrect colour + wrong spot"]
            end
        }
        #print @codeArray
        #print @correctindices
        #print @halfcorrect
    end

    def printcurguess
        print @playerCurGuess
    end

    def checkwin
        status = "play"
        if @correctindices.length == 4
            status = "win"
        elsif @guesstally == 12
            status = "lose"
        end
        status
    end

    def computerguess
        # if its the first guess, completely random colour/indices selection
        if @guesstally == 0
            for i in 0..3
                @computerCurGuess[i] = @colours[rand(5)]
            end
        else
            # if not first guess, skip over correct guesses if there are any
            @computerCurGuess.each_with_index{|colour, index|
                if @correctindices.include?(index) == false
                    # if there were previous guesses with correct colours in the wrong spot, prioritize those
                    if @halfcorrect != []
                        @computerCurGuess[index] = @halfcorrect[rand(@halfcorrect.length)]
                    else
                        @computerCurGuess[index] = @colours[rand(5)]
                    end
                end
            }
        end
        @guesstally += 1
        @computerCurGuess
    end

    def gettally
        @guesstally
    end

end

def playgame(player)
    game = Mastermind.new()
    game.randomselect
    if player == "player"
        while game.checkwin == "play"
            game.checkguess(game.playerguess)
        end
        if game.checkwin == "win"
            puts "The player correctly guessed the code in #{game.gettally} guesses"
        elsif game.checkwin == "lose"
            puts "The player did not correctly guess the code in #{game.gettally} guesses"
        end
    elsif player == "computer"
        while game.checkwin == "play"
            game.checkguess(game.computerguess)
        end
        if game.checkwin == "win"
            puts "The computer correctly guessed the code in #{game.gettally} guesses"
        elsif game.checkwin == "lose"
            puts "The computer did not correctly guess the code in #{game.gettally} guesses"
        end
    end
end

playgame("computer")

#game = Mastermind.new()
#print game.randomselect
#puts ''
#compGuess = game.computerguess
#puts "first guess"
#print compGuess
#game.checkguess(compGuess)
#puts ''
#puts "second guess"
#compGuess2 = game.computerguess
#print compGuess2
#game.checkguess(compGuess2)


#print game.randomselect
#playerguess = game.playerguess
#game.checkguess(playerguess)
#palyerguess2 = game.playerguess
#game.checkguess(palyerguess2)

#game.printcurguess