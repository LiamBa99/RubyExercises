def merge(left, right)
    sorted = []

    until left.empty? || right.empty?
        if left[0] <= right[0]
            sorted << left.shift
        else
            sorted << right.shift
        end
    end

    sorted.concat(left).concat(right)
end

def sort(array)
    if array.length <= 1
        return array
    end

    left = 0
    right = array.length-1
    mid = right/2

    left_arr = array[left..mid]
    right_arr = array[mid+1..right]

    sort_left = sort(left_arr)
    sort_right = sort(right_arr)

    merge(sort_left, sort_right)
end


ex2_array = [5,3,7]
ex_array = [5,1,6,9,12,4,67,5]
p sort(ex_array)