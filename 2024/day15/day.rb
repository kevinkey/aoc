map = [[]]
moves = []
pos = [0, 0]

File.read(File.join(File.dirname(__FILE__), "input.txt")).each_char do |char|
    case char
    when '#','O','.'
        map.last << char
    when '@'
        map.last << char
        pos[1] = map.count - 1
        pos[0] = map.last.count - 1
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

def move(map, pos, move)

    next_pos = pos.clone

    case move
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

    case map[next_pos[1]][next_pos[0]]
    when '.'
        valid = true
    when '#'
        valid = false
    when 'O'
        valid = move(map, next_pos, move)
    end

    if valid
        obj = map[pos[1]][pos[0]]
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
    move(map, pos, m)
end

total = 0
map.each_with_index do |row,y|
    row.each_with_index do |obj,x|
        if obj == 'O'
            total += y * 100 + x
        end
    end
end

puts total

