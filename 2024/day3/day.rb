def mul(text)
    text.scan(/mul\((\d+),(\d+)\)/).map{|m| m[0].to_i * m[1].to_i}.reduce(:+)
end

f = File.read("day3/input.txt")

dont = f.split("don't()")

total = mul(dont[0])

dont.drop(1).each do |d|
    d.split("do()").drop(1).each do |o|
        total += mul(o)
    end
end

puts total
