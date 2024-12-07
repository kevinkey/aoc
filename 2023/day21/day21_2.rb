
steps = 26501365
puts (steps + 1) ** 2

radius = 202300

blocks = 404599
total = blocks
loop do
    blocks -= 2
    break if blocks < 0
    total += blocks * 2
end
puts total



def count(map, char)
    total = 0
    map.each do |r|
      r.each do |c|
        if c == char
          total += 1
        end
      end
    end
    total
end

full = count(File.read("day21/full.txt").lines.map {|l| l.chars}, "O")
num = (radius ** 2) + ((radius - 1) ** 2)
puts "FULL: " + full.to_s
puts "NUM: " + num.to_s
puts full * num

full = count(File.read("day21/full.txt").lines.map {|l| l.chars}, ".")
num = (radius ** 2) + ((radius - 1) ** 2)
puts "NFULL: " + full.to_s
puts "NUM: " + num.to_s
puts full * num

map = File.read("day21/full.txt").lines.map {|l| l.chars}






#ROW = 0
#COL = 1
#X = 2
#Y = 3
#COUNT = 4
#
#$total = 0
#
#$map = File.read("day21/input.txt").lines.map {|l| l.chars}
#$map.map! {|r| r.map! {|t| {tile: t, state: []}}}
#
#start = []
#
#$map.each_with_index do |r, ri|
#  r.each_with_index do |c, ci|
#    if c[:tile] == "S"
#      start = [ri, ci, 0, 0, 26501365]
#      break;
#    end
#  end
#end
#
#def move(pos)
#  $map[pos[ROW]][pos[COL]][:state] << pos
#  if (pos[COUNT] > 0)
#    {
#      north: [-1, 0],
#      sount: [1, 0],
#      west: [0, -1],
#      east: [0, 1]
#    }.each do |k,v|
#      next_pos = [pos[ROW] + v[ROW], pos[COL] + v[COL], pos[X], pos[Y], pos[COUNT] - 1]
#
#      if next_pos[ROW] < 0
#        next_pos[ROW] = $map.count - 1
#        next_pos[Y] -= 1
#      elsif next_pos[ROW] >= $map.count
#        next_pos[ROW] = 0
#        next_pos[Y] += 1
#      elsif next_pos[COL] < 0
#        next_pos[COL] = $map[0].count - 1
#        next_pos[X] -= 1
#      elsif next_pos[COL] >= $map[0].count
#        next_pos[COL] = 0
#        next_pos[X] += 1
#      end
#
#      if $map[next_pos[ROW]][next_pos[COL]] == "#"
#        # rocks position
#      elsif $map[next_pos[ROW]][next_pos[COL]][:state].include?(next_pos)
#        # already visited position with same state
#      else
#        move(next_pos)
#      end
#    end
#  else
#    $total += 1
#  end
#end
#
#move(start)
#
##$map.each do |r|
##  puts r.map {|c| c[:tile]}.reduce(:+)
##end
#
#puts $total
#