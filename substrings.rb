def substrings (word, array)
    #iterate through the array, check if word in dictionary is contained in the word
    #if it is, add substring to a hash and iterate the hash count
    #return the hash
    subCount = Hash.new(0)
    word = word.split(" ")
    for i in 0..word.length-1
        array.each_with_index{|subString,index|
            if word[i].downcase.include?(subString)
                subCount[subString] += 1
            end
        }
    end
    subCount
end


fullString = "Howdy partner, sit down! How's it going?"
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings(fullString, dictionary)