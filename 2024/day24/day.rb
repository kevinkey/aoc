class Wire
    @@signals = []

    attr_reader :name

    def initialize(name, initial = nil)
        @name = name
        @initial = initial
        if initial && (initial != 0) && (initial != 1)
            raise "Invalid initial value #{initial} for #{name}"
        end
        @@signals << self
    end

    def state()
        @initial
    end

    def self.by_name(name)
        @@signals.find {|s| s.name == name}
    end

    def self.z()
        value = 0
        64.times do |i|
            w = Wire.by_name(sprintf("z%02d", i))
            break if !w
            value = value | (w.state << i)
        end
        value
    end
end

class OutputWire < Wire
    def initialize(name, operands, op)
        super(name)
        @operands = operands
        @op = op
    end

    def state()
        case @op
        when "AND"
            Wire.by_name(@operands[0]).state & Wire.by_name(@operands[1]).state
        when "OR"
            Wire.by_name(@operands[0]).state | Wire.by_name(@operands[1]).state
        when "XOR"
            Wire.by_name(@operands[0]).state ^ Wire.by_name(@operands[1]).state
        else
            raise "Unknown operand for #{@name}"
        end
    end
end

File.readlines(File.join(File.dirname(__FILE__), "input.txt")).each do |line|
    puts line
    if line =~ /(\w+):\s*(0|1)/
        Wire.new($1, $2.to_i)
    elsif line =~ /(\w+)\s+(\w+)\s+(\w+)\s+\-\>\s+(\w+)/
        OutputWire.new($4, [$1, $3], $2)
    elsif line.strip == ""
        # Skip empty lines
    else
        raise "Failed to parse!"
    end
end

puts Wire.z
