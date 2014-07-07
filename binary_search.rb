class ArrayUtil
  def self.bsearch (array, element)
    return false if array.length == 0
    if _bsearch(array, element) != nil
      return true
    else
      return false
    end
  end

  def self._bsearch(array, find, f_index=0, l_index=array.length-1)
    # puts "array: #{array}"
    midpoint = (array.length - 1) / 2
    # puts "midpoint: #{midpoint}"

    # p "f_index #{f_index}"
    # p "l_index #{l_index}"

    if array.length == 1
      return nil if array[0] != find
    end

    if array[midpoint] > find
      return nil if array[0] > find
      index = self._bsearch(array[0..(midpoint-1)], find, f_index, (l_index - array[midpoint..-1].length))
    end 

    if array[midpoint] < find
      return nil if array[-1] < find
      index = self._bsearch(array[(midpoint+1)..-1], find, (f_index + array[0..midpoint].length), l_index)
    end
    
    return index if !index.nil?

    return (f_index + midpoint) if array[midpoint] == find
  end

  def self.closest_recursive_search(array, find, f_index=0, l_index=array.length-1)
    # puts "array: #{array}"
    midpoint = (array.length - 1) / 2
    # puts "midpoint: #{midpoint}"

    # p "f_index #{f_index}"
    # p "l_index #{l_index}"

    if array.length == 1
      return nil if array[0] != find
    end

    if array[midpoint] > find
      return f_index if array[0] > find
      index = self.closest_recursive_search(array[0..(midpoint-1)], find, f_index, (l_index - array[midpoint..-1].length))
    end 

    if array[midpoint] < find
      return l_index if array[-1] < find
      index = self.closest_recursive_search(array[(midpoint+1)..-1], find, (f_index + array[0..midpoint].length), l_index)
    end
    
    return index if !index.nil?

    return (f_index + midpoint) if array[midpoint] == find
  end
end
