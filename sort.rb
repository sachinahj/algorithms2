module Sort

  def self.selection_sort(array)
    return [] if array.empty? 
    return array if array.size == 1
    start = 0
    index = 0
    min_value = 0
    min_index = 0
    finish = array.size

    while start < finish
      index = start
      min_value = array[index]
      min_index = index
      while index < finish
        min_index = index if array[index] < min_value 
        min_value = array[index] if array[index] < min_value 
        index +=1
      end
      array[min_index], array[start] = array[start], array[min_index]
      start += 1
    end

    return array

  end

end


