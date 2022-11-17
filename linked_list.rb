class Node

    def initialize(value = nil, next_node = nil)
        @value = value
        @next_node = next_node
    end

    def value()
        @value
    end

    def mod_next_node(node)
        @next_node = node
    end

    def next_node()
        @next_node
    end

    def print_next
        puts @next_node.value
    end
end

class LinkedList
    
    def initialize()
        @head = nil
        @tail = nil
        @size = 0
    end

    def append(value)
        newNode = Node.new(value, nil)
        @size += 1

        if @head != nil
            @head.mod_next_node(newNode)
            @head = newNode
        end

        if @head == nil 
            @head = newNode
        end
        
        if @tail == nil
            @tail = newNode
        end


    end

    def prepend(value)
        newNode = Node.new(value)
        @size += 1
        if @head == nil
            @head = newNode
        elsif @tail == nil
            @tail = newNode
        end

        if @tail != nil
            newNode.mod_next_node(@tail)
            @tail = newNode
        end 
    end

    def size
        @size
    end

    def head
        @head
    end

    def tail
        @tail
    end

    def at(index)
        if index > @size-1
            return nil
        end

        node = @tail
        for i in 0..index
            node = node.next_node
        end

        node
    end

    def pop 
        node = @tail

        for i in 0..@size-1
            node = node.next_node
        end

        @head = node
        node.mod_next_node(nil)
        @size =- 1
    end

    def contains?(value)
        node = @tail
        for i in 0..@size
            if node.value == value
                return true
            end
            node = node.next_node
        end
        return false
    end

    def find(value)
        node = @tail
        found = nil
        for i in 0..@size-1
            if node.value == value
                found = i
            end
            node = node.next_node
        end
        found
    end

    def to_s
        stringArray = []
        node = @tail
        for i in 0..@size-1
            stringArray.push("( ")
            stringArray.push(node.value)
            if node.next_node != nil
                stringArray.push(" ) -> ")
            else
                stringArray.push(" ) ")
            end
            node = node.next_node
        end

        stringArray
    end
end

list = LinkedList.new()

list.append(6)
list.prepend(12)
list.append(69)
#list.append("yo")

#puts list.head.value
#puts list.tail.value
#puts list.size
#puts list.find("yo")
#puts list.contains?(69)

#puts list.tail.value
#puts list.tail.next_node.value
#puts list.tail.next_node.next_node.value
#puts list.tail.next_node.next_node.next_node.value

#string_array = list.to_s

#puts string_array.join("")