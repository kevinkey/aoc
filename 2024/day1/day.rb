list1 = []
list2 = []

File.readlines("day1/input.txt").each do |line|
    numbers = line.split(/\s+/)

    list1 << numbers[0].to_i
    list2 << numbers[1].to_i
end

similarity = 0

list1.each do |n|
    count = 0
    similarity += list2.select {|m| m == n}.count * n
end

puts similarity


list1.sort!
list2.sort!

sum = 0

list1.each_with_index do |n, i|
    sum += (n - list2[i]).abs
end

puts sum
