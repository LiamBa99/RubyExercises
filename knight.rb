class Node

    attr_accessor :coord, :parent, :left_u, :left_d, :right_u, :right_d, :up_l, :up_r, :down_l, :down_r

    def initialize(coord, parent = nil, left_u = nil, left_d = nil, right_u = nil, right_d = nil, up_l = nil, up_r = nil, down_l = nil, down_r = nil)
        @parent = parent
        @coord = coord
        @left_u = left_u
        @left_d = left_d
        @right_u = right_u
        @right_d = right_d
        @up_l = up_l
        @up_r = up_r
        @down_l = down_l
        @down_r = down_r
    end

    def access_node_connections
        if block_given?
            yield @left_u
            yield @left_d
            yield @right_u
            yield @right_d
            yield @up_l
            yield @up_r
            yield @down_l
            yield @down_r
        else
            puts "No block given"
            nil
        end
    end

end

class Knight

    attr_accessor :chess_board, :starting_point

    def initialize()
        # create a board of 8x8 via a nested array of coords
        @chess_board = Array.new(8) { Array.new(8) }

        for x in 0..7
            for y in 0..@chess_board[x].length-1
                @chess_board[x][y] = [x,y]
            end
        end

        # create a root node at the current location
        @starting_point = Node.new(@chess_board[0][0])
    end

    def is_valid?(x, y)
        valid = true
            if x < 0 || x > 7
                valid = false
            elsif y < 0 || y > 7
                valid = false
            end
        valid
    end

    def generate_moves(starting_point = @starting_point)
        x_axis = starting_point.coord[1]
        y_axis = starting_point.coord[0]


        # left and up move
        if is_valid?(y_axis-1,x_axis-2)
            starting_point.left_u = Node.new(@chess_board[y_axis-1][x_axis-2],starting_point)
        else
            starting_point.left_u = nil
        end

        # left and down move
        if is_valid?(y_axis+1,x_axis-2)
            starting_point.left_d = Node.new(@chess_board[y_axis+1][x_axis-2],starting_point)
        else
            starting_point.left_d = nil
        end

        # right and up move
        if is_valid?(y_axis-1,x_axis+2)
            starting_point.right_u = Node.new(@chess_board[y_axis-1][x_axis+2],starting_point)
        else
            starting_point.right_u = nil
        end

        # right and down move
        if is_valid?(y_axis+1,x_axis+2)
            starting_point.right_d = Node.new(@chess_board[y_axis+1][x_axis+2],starting_point)
        else
            starting_point.right_d = nil
        end
        
        # up and left move
        if is_valid?(y_axis-2,x_axis-1)
            starting_point.up_l = Node.new(@chess_board[y_axis-2][x_axis-1],starting_point)
        else
            starting_point.up_l = nil
        end

        # up and right move
        if is_valid?(y_axis-2,x_axis+1)
            starting_point.up_r = Node.new(@chess_board[y_axis-2][x_axis+1],starting_point)
        else
            starting_point.up_r = nil
        end

        # down and left move
        if is_valid?(y_axis+2,x_axis-1)
            starting_point.down_l = Node.new(@chess_board[y_axis+2][x_axis-1],starting_point)
        else
            starting_point.down_l = nil
        end

        # down and right move
        if is_valid?(y_axis+2,x_axis+1)
            starting_point.down_r = Node.new(@chess_board[y_axis+2][x_axis+1],starting_point)
        else
            starting_point.down_r = nil
        end
    end

    def print_parents(node)
        print_parents(node.parent) unless node.parent.nil?
        p node.coord
    end

    def choose_next_move(starting_node, target_node)
        # build a list of possible moves from current node
        # add the possible moves to the node each move
        if starting_node.is_a?(Array)
            starting_node = Node.new(starting_node)
        end

        queue = []

        until starting_node.coord == target_node
            generate_moves(starting_node)
            starting_node.access_node_connections do |node|
                if node != nil
                    queue.push(node)
                end
            end
            starting_node = queue.shift
        end     
        print_parents(starting_node)
    end

end


knight = Knight.new()

knight.choose_next_move([4,4],[2,1])

