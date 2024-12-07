$map = File.read("day21/input.txt").lines.map {|l| l.chars}
$moves = Array.new($map.count) {Array.new($map[0].count) {[]}}

start = []

$map.each_with_index do |r, ri|
  r.each_with_index do |c, ci|
    if c == "S"
      start = [ri, ci]
      break;
    end
  end
end

def move(pos, count)
  $moves[pos[0]][pos[1]] << count
  if (count > 0)
    {
      north: [-1, 0],
      sount: [1, 0],
      west: [0, -1],
      east: [0, 1]
    }.each do |k,v|
      next_pos = [pos[0] + v[0], pos[1] + v[1]]

      if (next_pos[0] < 0) or (next_pos[0] >= $map.count)
        # invalid x position
      elsif (next_pos[1] < 0) or (next_pos[1] >= $map[0].count)
        # invalid y position
      elsif $map[next_pos[0]][next_pos[1]] == "#"
        # rocks position
      elsif $moves[next_pos[0]][next_pos[1]].include?(count - 1)
        # already visited position with same moves left
      else
        move(next_pos, count - 1)
      end
    end
  else
    $map[pos[0]][pos[1]] = "O"
  end
end

move(start, 64)

#$map[start[0]][start[1]] = "S"

$map.each do |r|
  puts r.reduce(:+)
end

total = 0
$map.each do |r|
  r.each do |c|
    if c == "O"
      total += 1
    end
  end
end

puts total

