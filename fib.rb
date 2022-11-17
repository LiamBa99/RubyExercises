def fib(number)
    arr = []

    for i in 0..number
        if i == 0 || i == 1
            arr << i
        else
            arr << (arr[i-1] + arr[i-2])
        end
    end
    arr 
end

puts fib(8)
