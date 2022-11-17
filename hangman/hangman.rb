require 'json'

class Hangman

    def initialize(alpha_list = [], secret_word = '', user_guess = [], guesses_left = 6)
        # gets from user, if they want to load a save: check if theres a file
        # if file available, load it
        @alpha_list = alpha_list
        @secret_word = secret_word
        @user_guess = user_guess
        @guesses_left = guesses_left
    end

    def pick_word
        word_list = File.read('google-10000-english-no-swears.txt')
        word_array = word_list.split(' ')
        word_found = false

        while(!word_found)
            rand_num = rand(word_array.length)
            if word_array[rand_num].length > 4 && word_array[rand_num].length < 13
                rand_word = word_array[rand_num]
                word_found = true
            end
        end
        @secret_word = rand_word.split('')
        for i in 0..@secret_word.length-1
            @user_guess.push("_")
        end
        print @secret_word
    end

    def check_guess(guess)
        found = false
        
        if @user_guess.include?(guess)
            puts "You have already guessed that letter!"
        elsif @secret_word.include?(guess) && @user_guess.include?(guess) == false
            @alpha_list.push(guess)
            @secret_word.each_with_index do |c, index|
                if c == guess
                    @user_guess[index] = guess
                    found = true
                end
            end
        else
            @alpha_list.push(guess)
            @guesses_left = @guesses_left-1
        end
        found
    end
    
    def get_input
        print @user_guess
        puts ''
        puts "You have #{@guesses_left} guesses left"
        puts "These are the letters you have chosen already: #{@alpha_list}"
        
        input = gets.strip.downcase

        if input == "exit"
            exit
        end

        input
    end

    def save_to_json
        filename = "saved_game.json"

        json_string = JSON.dump ({
            :alpha_list => @alpha_list,
            :secret_word => @secret_word,
            :user_guess => @user_guess,
            :guesses_left => @guesses_left
        })

        File.open(filename, 'w') do |f|
            f.write(json_string)
        end 
    end

    def load_from_json
        file = File.read('saved_game.json')
        
        data = JSON.parse(file)

        @alpha_list = data['alpha_list']
        @secret_word = data['secret_word']
        @user_guess = data['user_guess']
        @guesses_left = data['guesses_left']
    end

    def check_win()
        if @user_guess == @secret_word
            win = true
        elsif @guesses_left == 0
            win = false
        end
    end

    def get_secret_word
        @secret_word
    end

    def get_guesses 
        @guesses_left
    end

end

def play_game()
    game = Hangman.new()

    if File.exists?('saved_game.json')
        puts "Would you like to load from a previous save? (Y/N)"
        input = gets.strip.downcase

        if input == "y"
            game.load_from_json
        else
            game.pick_word
        end
    else
        game.pick_word
    end 

    secret = game.get_secret_word
    secret = secret.join('')

    while game.check_win != false && game.check_win != true
        game.save_to_json
        game.check_guess(game.get_input)
    end

    if game.check_win == false
        puts "You lost! The answer was: #{secret}"
        File.delete('saved_game.json')
    elsif game.check_win == true
        guesses = game.get_guesses
        puts "You won! You got the answer: #{secret} with #{guesses} guesses left!"
        File.delete('saved_game.json')
    end

end





play_game