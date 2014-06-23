require 'pry-byebug'

module MergeSort

  def self.sort(array)
    return array if array.length <= 1
    half = array.length / 2 - 1

    # puts "array: #{array}"
    # puts "halfi: #{half}"
    # puts "half1: #{array[0..half]}"
    # puts "half2: #{array[half+1..-1]}"

    # binding.pry

    first = sort(array[0..half]) 
    second = sort(array[half+1..-1])
    
    array = MergeSort.merge(first, second)
    return array
  end

  def self.merge(first, second)
    first_index = 0
    second_index = 0
    array = []
    while first_index < first.length && second_index < second.length 
      if first[first_index] <= second[second_index]
        array << first[first_index]
        first_index += 1
      else
        array << second[second_index]
        second_index += 1
      end
    end
    if first_index == first.length
      array += second[second_index...second.length]
    else
      array += first[first_index...first.length]
    end
    # p array
    return array
  end

end

# sort([123,23,65,8,3,7,4,8,54,3,6567,89,542,45,7,45,2,34,6,67,83,45,23,446,67,76,3])

# merge([1,4,5,8],[2,7,8,9])
