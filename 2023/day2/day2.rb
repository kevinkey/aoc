total = 0

File.read("day2/input.txt").each_line do |line|
    game = /Game (\d+)\:/.match(line).captures[0].to_i

    min = {"red" => 0, "green" => 0, "blue" => 0}

    line.split(":")[1].split(";").each do |set|
       set.split(",").each do |cubes|
            count = cubes.split(" ")[0].to_i
            color = cubes.split(" ")[1]

            min[color] = [count, min[color]].max
       end
    end

    puts min

    total += (min["red"] * min["blue"] * min["green"])
end

puts total