def simple_adding(number)
  sum = 0
  (number + 1).times do |i|
    sum += i
  end
  sum
end

puts simple_adding(140)
