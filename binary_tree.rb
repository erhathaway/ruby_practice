require 'pry'

class Tree
  attr_accessor :nodes
  attr_reader :tree

  def initialize
    @tree = nil
  end

  def add_node(number)
    #if no tree exists
    if @tree.nil?
      @tree = Node.new(number)
      @tree.level = 0

    #if tree exists, transverse tree to branch end
    else
      end_tree = false
      node = @tree

      while end_tree == false
        current_level = node.level
        #if left branch
        if number < node.value
          if node.left_child
            node = node.left_child
          else
            end_tree = true
            node.left_child = Node.new(number)
            node.left_child.level = current_level + 1
          end

        #if right branch
        else
          if node.right_child
            node = node.right_child
          else
            end_tree = true
            node.right_child = Node.new(number)
            node.right_child.level = current_level + 1
          end
        end

      end
    end
  end

  def build_print_hash
    # print_hash = Hash.new([])
    # print_array = []
    print_hash = {}
    queue = [tree]

    while queue.length > 0
      node = queue.shift

      if print_hash[node.level] == nil
        print_hash[node.level] = []
      end
      # print_hash[node.level] << node.value
      # print_array << [node.value, node.level]
      # print_array << node.level
      print_hash[node.level] << node.value

      if node.left_child
        queue << node.left_child
      end
      if node.right_child
        queue << node.right_child
      end
    end


    print_hash
    # print print_array

  end

  # end

end

class Node
  attr_reader :value
  attr_accessor :left_child, :right_child, :level

  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
    @level = nil
  end
end

tree = Tree.new
tree.add_node(44)
tree.add_node(3)
tree.add_node(44)
tree.add_node(1)
tree.add_node(40)
tree.add_node(200)
tree.add_node(44)

def display_tree(print_hash)
  print_hash.values.each do |level|
    puts level.to_s.gsub(/[\[\],]/,'')
  end
end

print_hash = tree.build_print_hash
display_tree(print_hash)
# tree.print_tree
#
