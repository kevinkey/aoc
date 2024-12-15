map = [[]]
moves = []
pos = [0, 0]

File.read(File.join(File.dirname(__FILE__), "input.txt")).each_char do |char|
    case char
    when '#','.'
        map.last << char
        map.last << char
    when 'O'
        map.last << '['
        map.last << ']'
    when '@'
        map.last << char
        pos[1] = map.count - 1
        pos[0] = map.last.count - 1
        map.last << '.'
    when "\n"
        map << []
    when '<','>','^','v'
        moves << char
    end
end

map.reject! {|row| row.count <= 0}

def print_map(map)
    map.each do |row|
        row.each do |char|
            print(char)
        end
        puts
    end
end

def move(map, pos, m)

    next_pos = pos.clone

    case m
    when '<'
        next_pos[0] -= 1
    when '>'
        next_pos[0] += 1
    when '^'
        next_pos[1] -= 1
    when 'v'
        next_pos[1] += 1
    end

    valid = false

    obj = map[pos[1]][pos[0]]
    next_obj = map[next_pos[1]][next_pos[0]]

    case next_obj
    when '.'
        valid = true
    when '#'
        valid = false
    when '[',']'
        if ['<', '>'].include?(m) or (next_obj == obj)
            valid = move(map, next_pos, m)
        elsif next_obj == '['
            if move(map, next_pos, m)
                right_pos = next_pos.clone
                right_pos[0] += 1
                valid = move(map, right_pos, m)
            end
        else
            if move(map, next_pos, m)
                left_pos = next_pos.clone
                left_pos[0] -= 1
                valid = move(map, left_pos, m)
            end
        end
    end

    if valid
        map[next_pos[1]][next_pos[0]] = obj
        map[pos[1]][pos[0]] = '.'
        if obj == '@'
            pos[0] = next_pos[0]
            pos[1] = next_pos[1]
        end
    end

    valid
end

moves.each do |m|
    orig = Marshal.load(Marshal.dump(map))
    if !move(map, pos, m)
        map = orig
    end
end

total = 0
map.each_with_index do |row,y|
    row.each_with_index do |obj,x|
        if obj == '['
            total += y * 100 + x
        end
    end
end

puts total
