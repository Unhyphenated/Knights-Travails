module Searchable
    def dfs(target_value=nil)
        return self if target_value == self.value

        children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?
        end

        nil
    end


    def bfs(target_value=nil)
        nodes = [self]

        until nodes.empty?
            node = nodes.shift

            return node if node.value == target_value
            node.children.each { |child| nodes << child }
        end
        nil
    end
end


class PolyTreeNode
    include Searchable
    attr_accessor :value
    attr_reader :parent

    def initialize(value=nil)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent)
        return if self.parent == parent
        
        if self.parent
            self.parent._children.delete(self)
        end

        @parent = parent
        self.parent._children << self unless self.parent.nil?

    end

    def children
        @children.dup
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        if child && !self.children.include?(child)
            raise "Tried to remove a node that isn't a child!"
        end
        child.parent = nil
    end

    def inspect
        
    end

    protected

    def _children
        @children
    end

end

n1 = PolyTreeNode.new("root1")
n2 = PolyTreeNode.new("root2")
n3 = PolyTreeNode.new("root3")

n1.add_child(n3)
n1.inspect





