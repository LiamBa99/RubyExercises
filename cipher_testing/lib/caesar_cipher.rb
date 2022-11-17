

def cipher (string, shift)
    special = "?<>',?[]}{=-)(*@&^%$#`~{}!"
    regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
    alph = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    encrString = []
    string = string.split('')
    #iterate through each char of the word
    for i in  0..string.length-1
        #if char is a space or special character, keep it
        if string[i] =~ regex || string[i] == " "
            encrString.push(string[i])
        end
        alph.each_with_index{|alpha, index|
            if string[i].downcase == alpha
                #if alph index of char is > 25 - shift, then shifted index is alph index + shift - 25
                if index > alph.length - shift - 1
                    if string[i] == string[i].upcase
                        encrString.push(alph[index+shift-alph.length].upcase)
                    else
                        encrString.push(alph[index+shift-alph.length])
                    end
                else
                    if string[i] == string[i].upcase
                        encrString.push(alph[index+shift].upcase)
                    else
                        encrString.push(alph[index+shift])
                    end
                end
            end
        }
    end


    
p encrString.join("")
end

