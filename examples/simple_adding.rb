def simple_adding(number)
  i = 0
  sum = 0
  number.times do
    i = i + 1
    sum += i
  end
  sum
end

puts simple_adding(140)
