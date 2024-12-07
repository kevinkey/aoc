def is_safe(numbers, skip = nil)
    diffs = []

    copy = numbers.clone
    copy.delete_at(skip) if skip

    copy.each_with_index do |n, i|
        if i != 0
            diffs << n - copy[i - 1]
        end
    end

    max = diffs.max
    min = diffs.min

    if min >= 1 and max <= 3
        true
    elsif min >= -3 and max <= -1
        true
    else
        false
    end
end

safe = 0

File.readlines("day2/input.txt").each do |line|
    numbers = line.split(/\s+/).map {|s| s.to_i}

    if is_safe(numbers)
        safe += 1
    else
        numbers.count.times do |i|
            if is_safe(numbers, i)
                safe += 1
                break
            end
        end
    end
end

puts safe