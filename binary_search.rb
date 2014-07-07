class Binary
  def self.recursive_search(array, find, f_index=0, l_index=array.length-1) 
    # puts "array: #{array}"
    midpoint = (array.length - 1) / 2
    # puts "midpoint: #{midpoint}"

    # p "f_index #{f_index}"
    # p "l_index #{l_index}"

    if array.length == 1
      return nil if array[0] != find
    end

    if array[midpoint] > find
      index = self.recursive_search(array[0..(midpoint-1)], find, f_index, (l_index - array[midpoint..-1].length))
    end 

    if array[midpoint] < find
      index = self.recursive_search(array[(midpoint+1)..-1], find, (f_index + array[0..midpoint].length), l_index)
    end
    
    return (f_index + midpoint) if array[midpoint] == find

    return index if !index.nil?
  end
end

p Binary.recursive_search([2,4,6,8,10,14,15], 2)
p Binary.recursive_search([2,4,6,8,10,14,15], 4)
p Binary.recursive_search([2,4,6,8,10,14,15], 6)
p Binary.recursive_search([2,4,6,8,10,14,15], 8)
p Binary.recursive_search([2,4,6,8,10,14,15], 10)
p Binary.recursive_search([2,4,6,8,10,14,15], 14)
p Binary.recursive_search([2,4,6,8,10,14,15], 15)

array = [-9,1,2,4,5,7,11,23,54]

p Binary.recursive_search(array, -9)
p Binary.recursive_search(array, 1)
p Binary.recursive_search(array, 2)
p Binary.recursive_search(array, 4)
p Binary.recursive_search(array, 5)
p Binary.recursive_search(array, 7)
p Binary.recursive_search(array, 11)
p Binary.recursive_search(array, 23)
p Binary.recursive_search(array, 54)