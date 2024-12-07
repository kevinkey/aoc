NUMBERS = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
]

total = 0

File.read("input.txt").each_line do |line|

    cal = ""

    temp = NUMBERS.map do |n|
        line.index(n) || 999999
    end

    temp = temp.each_with_index.min[1]
    temp -= 10 if temp > 9
    cal += temp.to_s

    temp = NUMBERS.map do |n|
        line.rindex(n) || -1
    end

    temp = temp.each_with_index.max[1]
    temp -= 10 if temp > 9
    cal += temp.to_s

    total += cal.to_i
end

puts total
