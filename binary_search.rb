# frozen_string_literal: true

class Node
    attr_accessor :left, :right, :data

    def initialize(data)
        @data = data
        @right = nil
        @left = nil
    end
end

class Tree
    
    attr_accessor :root, :data
    
    def initialize(array)
        @data = array.sort.uniq
        @root = build_tree(data)
    end

    def build_tree(array)
        return nil if array.empty?
        
        middle = (array.size - 1) / 2
        root_node = Node.new(array[middle])

        root_node.left = build_tree(array[0...middle])
        root_node.right = build_tree(array[(middle + 1)..-1])

        root_node
    end

    def insert(value, node = @root)

        if value > node.data
            if node.right != nil
                insert(value, node.right)
            else
                newNode = Node.new(value)
                node.right = newNode
            end
        elsif value < node.data
            if node.left != nil
                insert(value, node.left)
            else
                newNode = Node.new(value)
                node.left = newNode
            end
        elsif value == node.data
            puts "value already exists in tree"
            return
        end

    end

    def find_min(node)
        if node.left == nil
            return node
        else
            find_min(node.left)
        end
    end

    def delete(value, node = @root)

        if node == nil
            return node
        end

        if value > node.data
            node.right = delete(value, node.right)
        elsif value < node.data
            node.left = delete(value, node.left)
        elsif value == node.data
            if node.left == nil
                temp = node.right
                node = nil
                return temp
            elsif node.right == nil
                temp = node.left
                node = nil
                return temp
            end

            temp = find_min(node.right)

            node.data = temp.data

            node.right = delete(temp.data,node.right)
        end
        return node

    end

    def find(value, node = @root)

        if node.data == value
            return node
        elsif value > node.data
            if node.right == nil
                puts "Value does not exist"
                return
            end
            found_node = find(value,node.right)
        elsif value < node.data
            if node.left == nil
                puts "Value does not exist"
                return
            end
            found_node = find(value,node.left)
        end

        found_node
    end

    def level_order(node = @root, queue = [], &block)
        if block_given?
            yield node
        end

        if node.left != nil
            queue.push(node.left)
        end
        if node.right != nil
            queue.push(node.right)
        end

        if queue.empty? == false
            next_node = queue.shift()

            level_order(next_node, queue, &block)
        end
    end

    def preorder(node = @root, array = [], &block)
        if block_given?
            yield node
        end

        array.push(node.data)

        if node.left != nil
            preorder(node.left, array, &block)
        end
        
        if node.right != nil
            preorder(node.right, array, &block)
        end
        array
    end

    def inorder(node = @root, array = [], &block)
        
        if node.left != nil
            inorder(node.left, array, &block)
        end
        
        if block_given?
            yield node
        end

        array.push(node.data)

        if node.right != nil
            inorder(node.right, array, &block)
        end
        array
    end

    def postorder(node = @root, array = [], &block)
        
        if node.left != nil
            postorder(node.left, array, &block)
        end

        if node.right != nil
            postorder(node.right, array, &block)
        end
        
        if block_given?
            yield node
        end

        array.push(node.data)


        array
    end

    def height(node = @root)

        if node.nil?
            -1
        else
            node = find(node) if node.is_a?(Integer)

            left_counter = height(node.left)
            right_counter = height(node.right)

            if left_counter > right_counter
                1 + left_counter
            else
                1 + right_counter
            end
        end
    end

    def depth(target_node, start_node = @root, counter = 0)

        target_node = find(target_node) if target_node.is_a?(Integer)
        if start_node.nil?
            nil
        elsif start_node.data == target_node.data
            counter
        elsif start_node.data > target_node.data
            counter += 1 
            depth(target_node, start_node.left, counter)
        elsif start_node.data < target_node.data
            counter += 1
            depth(target_node, start_node.right, counter)
        end
    end

    def balanced?(node = @root)
        
        if node.nil?
            -1
        else
            node = find(node) if node.is_a?(Integer)

            left_counter = height(node.left)
            right_counter = height(node.right)

            if (left_counter - right_counter).abs > 1
                false
            else
                true
            end
        end
    end

    def rebalance
        array = self.postorder

        @data = array.sort.uniq
        @root = build_tree(data)
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end


(Array.new(15) {rand(1..100)})

tree = Tree.new(Array.new(15) {rand(1..100)})

p tree.balanced?

p tree.preorder
p tree.postorder
p tree.inorder

tree.insert(105)
tree.insert(106)
tree.insert(107)

p tree.balanced?

tree.rebalance

p tree.balanced?

#array = [4,10,12,15,18,22,24,25,31,35,44,50,66,70,90]

#tree = Tree.new(array)

#tree.insert(5)

#tree.delete(8)

#p tree.find(24)

#tree.level_order { |node| puts node.data }
#array = tree.preorder
#tree.postorder do |node| 
    #p node.data
#end

#puts tree.height(25)

#puts tree.depth(22, tree.root)

#puts tree.balanced?
tree.pretty_print

