require_relative "polytreenode.rb"

class KnightPathFinder
    attr_reader :considered_positions

    MOVES = [
        [-2, -1],
        [-2,  1],
        [ 2, -1],
        [ 2,  1],
        [-1, -2],
        [-1,  2],
        [ 1, -2],
        [ 1,  2]
    ]

    def self.valid_moves(pos)
        valid_moves = []
        c_x, c_y = pos
        MOVES.each do |(dx, dy)|
            new_pos = [c_x + dx, c_y + dy]

            if new_pos.all? { |coord| coord.between(0, 7) }
                valid_moves << new_pos
            end
        end

        valid_moves
    end

    def initialize(start_position)
        @start_position = start_position
        @considered_positions = [start_position]
    end

    def new_move_positions(pos)
        KnightPathFinder.valid_moves(pos)
        .reject { |move| considered_positions.include?(move) }
        .each { |move| considered_positions << move }
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(start_position)

        nodes = [root_node]
        until nodes.empty?
            current_node = nodes.shift

            current_pos = current_node.value

            new_move_positions(current_pos).each do |new_pos|
                new_node = PolyTreeNode.new(new_pos)
                current_node.add_child(new_node)

                nodes << new_node
            end
        end
    end
end


kpf = KnightPathFinder.new([0, 0])