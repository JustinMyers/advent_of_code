class Gate
  attr_reader :input_1, :input_2, :type
  
  def initialize( _input_1, _input_2, _type )
    @input_1 = _input_1
    @input_2 = _input_2
    @type = _type
  end
  
  def value
    @value ||= case type
    when "RSHIFT"
      input_1.value >> input_2.value
    when "LSHIFT"
      input_1.value << input_2.value
    when "AND"
      input_1.value & input_2.value
    when "OR"
      input_1.value | input_2.value
    when "NOT"
      ~input_2.value
    end
  end
end

class Wire
  attr_reader :identifier
  attr_accessor :input
  
  def initialize( _identifier, _input = nil )
    @input = _input
    @identifier = _identifier
  end
  
  def value
    @value ||= @input.value
  end
end

class StaticSignal
  attr_reader :value
  
  def initialize( _value )
    @value = _value
  end
end

input = File.open('inputs/day7_input.txt')

wires = {}

while instruction = input.gets
  puts instruction
  wire_1, value_1, gate, wire_2, value_2, destination_wire = instruction.match(
      /([a-z]*)?\s*([0-9]*)?\s*(LSHIFT|RSHIFT|AND|OR|NOT)?\s*([a-z]*)?\s*([0-9]*)? -> ([a-z]*)/
    ).captures
  # puts [wire_1, value_1, instruction, wire_2, value_2, destination_wire].inspect
  
  wire_1, value_1, gate, wire_2, value_2, destination_wire = [wire_1, value_1, gate, wire_2, value_2, destination_wire].map { |v| v == "" ? nil : v }
  
  wires[destination_wire] ||= Wire.new(destination_wire) if destination_wire
  wires[wire_1] ||= Wire.new(wire_1) if wire_1
  wires[wire_2] ||= Wire.new(wire_2) if wire_2
  
  wire = wires[destination_wire]
  wire_1 = wires[wire_1]
  wire_2 = wires[wire_2]
  
  value_1 = StaticSignal.new(value_1.to_i)
  value_2 = StaticSignal.new(value_2.to_i)
  
  if gate
    wire.input = Gate.new( (wire_1 || value_1), (wire_2 || value_2), gate )
  else
    if wire_1
      wire.input = wire_1
    elsif value_1
      wire.input = value_1
    end
  end
end

# This line solves the second half of the puzzle.
wires["b"].input = StaticSignal.new(46065)

puts "The signal on wire a is #{wires['a'].value}"