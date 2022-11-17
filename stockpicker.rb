def stock_picker(array)
    #iterate through array, calc differences between 0 -> length, then 1 -> length, etc..
    arrayLength = array.length-1
    profit = 0

    for i in 0..arrayLength
        for x in i..arrayLength
            dif = array[x] - array[i]
            if dif > profit
                profit = dif
                buyIndex = i
                sellIndex = x
            end
        end 
    end

    resultArray = [buyIndex, sellIndex, profit]
end


stockprices = [29,3,6,9,15,8,6,1,1]

puts stock_picker(stockprices)