def fib_recursive(number)
    if number == 0
        return [0]
    elsif number == 1
        return [0,1]
    end
    
    array = fib_recursive(number-1)

    array << array[-2] + array[-1]    
end

puts fib_recursive(8)