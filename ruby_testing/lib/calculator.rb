class Calculator
    def add(*args)
        sum = 0
        args.each do |num|
            sum += num
        end
        sum
    end

    def multiply(*args)
        if args.size == 0
            product = 0
        else
            product = 1
            args.each do |num|
                product *= num
            end
        end
        product
    end
  end