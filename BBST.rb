class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class Tree
  attr_reader :head

  def initialize
    @head = nil
  end

  def add_node(value)
    p value
    return @head = Node.new(value) unless @head
    add_helper(value, @head)
  end

  def search(value)
    node = @head
    while node
      if value == node.value
        return true 
      elsif value < node.value && node.left
        node = node.left
      elsif value > node.value && node.right
        node = node.right
      else
        return false
      end
    end
  end

  def rec_search(value)
    rec_search_helper(value, @head)
  end

  def rec_search_helper(value, node)
    if value == node.value
      return true
    elsif value < node.value && node.left
      rec_search_helper(value, node.left)
    elsif value > node.value && node.right
      rec_search_helper(value, node.right)
    else
      return false
    end
  end

  def balance
    tree_array = in_order
    @head = nil
    add_array(tree_array)
  end

  def add_array(array)
    return nil if array.empty?
    return add_node(array.first) if array.length == 1
    midpoint = array.length/2
    add_node(array[midpoint])
    add_array(array[0...midpoint])
    add_array(array[(midpoint+1)..-1])
  end

  private

  def rec_in_order
    @tree_array = []
    rec_in_order_helper(node)
    @tree_array
  end

  def rec_in_order_helper(node)
    rec_in_order_helper(node.left) if node.left
    @tree_array << node.value
    rec_in_order_helper(node.right) if node.right
  end

  def add_helper(value, node)
    if node.value == value
      return node
    elsif value < node.value
      if node.left
        add_helper(value, node.left)
      else
        node.left = Node.new(value)
      end
    else
      if node.right
        add_helper(value, node.right)
      else
        node.right = Node.new(value)
      end
    end
  end

  def in_order
    stack = []
    next_node = @head
    sol = []
    while !stack.empty? || next_node
      if next_node
        node = next_node
        next_node = node.left
        stack.push(node)
      else
        node = stack.pop
        sol << node.value
        next_node = node.right
      end
    end
    sol
  end

end

tree = Tree.new
tree.add_node(1)
tree.add_node(2)
tree.add_node(3)
tree.add_node(4)
tree.add_node(5)
tree.add_node(6)
tree.add_node(7)
tree.add_node(8)
tree.add_node(9)
tree.add_node(10)
tree.add_node(11)
tree.add_node(12)
tree.add_node(13)
tree.add_node(14)
tree.add_node(15)
