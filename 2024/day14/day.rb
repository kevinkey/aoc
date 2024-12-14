DIM = [101, 103]


class Robot

    def initialize(p, v)
        @p = p
        @v = v
        find_period()
        puts to_s()
    end

    def move()
        @p.map!.with_index {|p,i| (p + @v[i] + DIM[i]) % DIM[i]}
    end

    def to_s()
        "p = #{@p}, v = #{@v}, period = #{@period}"
    end

    def x()
        @p[0]
    end

    def y()
        @p[1]
    end

    def find_period()
        origin = @p.clone
        @period = 0
        loop do
            move()
            @period += 1
            break if origin == @p
        end
    end

    def inline?(rm)
        lines = [
            [
                [0, 1, 0],
                [0, 1, 0],
                [0, 1, 0],
            ],
            [
                [0, 0, 0],
                [1, 1, 1],
                [0, 0, 0],
            ],
            [
                [1, 0, 0],
                [0, 1, 0],
                [0, 0, 1],
            ],
            [
                [0, 0, 1],
                [0, 1, 0],
                [1, 0, 0],
            ],
        ]

        if (x <= 0) or (x >= (DIM[0] - 1))
            false
        elsif (y <= 0) or (y >= (DIM[1] - 1))
            false
        else
            window = [
                [rm[y - 1][x - 1] > 0 ? 1 : 0, rm[y - 1][x] > 0 ? 1 : 0, rm[y - 1][x + 1] > 0 ? 1 : 0],
                [rm[y    ][x - 1] > 0 ? 1 : 0, rm[y    ][x] > 0 ? 1 : 0, rm[y    ][x + 1] > 0 ? 1 : 0],
                [rm[y + 1][x - 1] > 0 ? 1 : 0, rm[y + 1][x] > 0 ? 1 : 0, rm[y + 1][x + 1] > 0 ? 1 : 0],
            ]
            lines.include?(window)
        end
    end
end

robots = []

File.readlines(File.join(File.dirname(__FILE__), "input.txt")).each do |line|
    if val = /p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/.match(line)
        robots << Robot.new([val[1].to_i, val[2].to_i], [val[3].to_i, val[4].to_i])
    else
        raise "Line '#{line}'did not match!"
    end
end

def r_map(r)
    rm = Array.new(DIM[1]) {Array.new(DIM[0]) {0}}

    r.each do |b|
        rm[b.y][b.x] += 1
    end

    rm
end

def print_map(rm)
    total = 0
    quad = [[0, 0], [0, 0]]
    q_y = 0
    skipped = 0

    rm.each_with_index do |row,y|
        mid_row = (y == (DIM[1] / 2))
        q_y = 1 if mid_row
        q_x = 0

        print("|")
        row.each_with_index do |cell,x|
            mid_cell = (mid_row or (x == (DIM[0] / 2)))
            q_x = 1 if mid_cell
            total += cell

            if mid_cell
                print(" ")
                skipped += cell
            elsif cell == 0
                print(".")
            else
                quad[q_y][q_x] += cell
                print(cell)
            end
        end
        print("|")
        puts
    end
    puts "total = #{total}"
    puts "quad = #{quad}"
    puts "skipped = #{skipped}"
    puts "safety factor = #{quad[0][0] * quad[0][1] * quad[1][0] * quad[1][1]}"
end

#100.times {robots.each {|r| r.move()}}

#print_map(r_map(robots))

t = 0
max = 0
loop do
    robots.each {|r| r.move()}
    t += 1
    rm = r_map(robots)
    inline = robots.select {|r| r.inline?(rm)}.count
    if inline > max
        max = inline
        print_map(rm)
        puts "time = #{t}"
        puts "inline = #{inline}"
    end
    break if t > 10403
end
