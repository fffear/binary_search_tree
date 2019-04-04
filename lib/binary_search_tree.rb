$LOAD_PATH << '.'
require 'node.rb'
require 'depth_first_search_class.rb'

class BinarySearchTree
  attr_accessor :array, :tree

  def initialize(array)
    @array = array
    @tree = self.build_tree
  end

  def build_tree #(array)
    head = Node.new

    self.array.each do |num|
      current_node = head
      (current_node.value.nil? && current_node == head) ? assign_root(current_node, num) : determine_node_position(current_node, num)
    end
    head
  end

  def assign_root(current_node, num)
    current_node.value = num
  end

  # determine correct node position
  def determine_node_position(current_node, num)
    loop do
      case
      when num >= current_node.value && current_node.right_child.nil? then assign_right_nodes(current_node, num)
      when num >= current_node.value && current_node.right_child != nil then current_node = current_node.right_child
      when num < current_node.value && current_node.left_child.nil? then assign_left_nodes(current_node, num)
      when num < current_node.value && current_node.left_child != nil then current_node = current_node.left_child
      end
    end
  end

  def assign_left_nodes(current_node, num)
    current_node.left_child = Node.new(num, current_node)
    raise StopIteration
  end

  def assign_right_nodes(current_node, num)
    current_node.right_child = Node.new(num, current_node)
    raise StopIteration
  end

  # breadth first search and it's helper functions
  def breadth_first_search(value)
    queue, current_node = [self.tree], self.tree

    while current_node.value != value
      return nil if queue.empty?
      current_node = queue.shift
      enqueue_child_nodes(current_node, queue)
    end
    "This is the returned node:\n\n#{current_node}" if current_node.value == value 
  end

  def enqueue_child_nodes(current_node, queue)
    queue << current_node.left_child if current_node.left_child != nil
    queue << current_node.right_child if current_node.right_child != nil
  end

  # depth first search
  def depth_first_search(value)
    DepthFirstSearch.new(self.tree, value).compute
  end

  #depth first search recursive
  def dfs_rec(value, node)
    return nil if node.nil?
    return node if node.value == value
    dfs_rec(value,node.left_child) ? dfs_rec(value,node.left_child) : dfs_rec(value,node.right_child)
  end
end