# Method Object for 'depth_first_search'
class DepthFirstSearch
attr_accessor :stack, :current_node, :value

  def initialize(current_node, value)
    @stack = [current_node]
    @current_node = current_node
    @value = value
  end

  def compute
    while current_node.nil? || current_node.value != value
      return nil if current_node.nil?
      if current_node_is_leaf_node?
        pop_stack_and_update_node
        loop { decision_if_right_child_exists }
        next
      end
      traverse_down_tree 
    end
    current_node
  end

  def current_node_is_leaf_node?
    current_node.left_child.nil? && current_node.right_child.nil?
  end

  def decision_if_right_child_exists
    if current_node.nil?
      raise StopIteration
    elsif current_node.right_child != nil
      update_current_node_to_right_child
      raise StopIteration
    elsif current_node.right_child.nil?
      pop_stack_and_update_node
    end
  end

  def traverse_down_tree
    case
    when current_node.left_child != nil then update_current_node_to_left_child
    when current_node.right_child != nil then update_current_node_to_right_child
    end 
  end

  def pop_stack_and_update_node
    stack.pop
    self.current_node = stack.last
  end

  def update_current_node_to_left_child
    stack << current_node.left_child
    self.current_node = stack.last
  end

  def update_current_node_to_right_child
    stack.pop
    stack << current_node.right_child
    self.current_node = stack.last
  end  
end

