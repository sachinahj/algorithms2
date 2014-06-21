def sort(array)
  half = array.length/2

  p 'halfi: #{half}'
  p 'half1: #{array[0..half]}'
  p 'half2: #{array[half..0]}'

  sort(array[0..half])
  sort(array[half..0])
end

sort([1,4,8,5,7,9,2,8])

