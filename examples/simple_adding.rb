def simple_adding(number)
  sum = 0
  number.times do |i|
    i = i + 1
    sum += i
  end
  sum
end

puts simple_adding(12)
