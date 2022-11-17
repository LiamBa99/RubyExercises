def bubblesort(array)
    lowest = array[0]
    temp = 0
    for i in 0..array.length-1
        for x in i..array.length-1
            if array[x] < array[i]
                temp = array[i]
                array[i] = array[x]
                array[x] = temp
            end
        end
    end
    array
end


puts bubblesort([4,3,78,2,0,2])