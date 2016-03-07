input = File.open('inputs/day16_input.txt')

"Sue 1: children: 1, cars: 8, vizslas: 7"

def strip_last(s)
  s.slice!(-1..s.length)
  s
end

@aunts = {}

while line = input.gets
  line = line.split
  
  number, k1, v1, k2, v2, k3, v3 = [
    strip_last(line[1]).to_i,
    strip_last(line[2]),
    strip_last(line[3]).to_i,
    strip_last(line[4]),
    strip_last(line[5]).to_i,
    strip_last(line[6]),
    line[7].to_i
  ]
  
  @aunts[number] = {
    k1 => v1,
    k2 => v2,
    k3 => v3
  }
end

@clues = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1
}

@aunts.each do |aunt|
  number = aunt[0]
  attributes = aunt[1]
  match = true
  attributes.each do |attribute|
    key = attribute[0].to_sym
    if key == :cats || key == :trees
      unless @clues[attribute[0].to_sym] < attribute[1]
        match = false
      end
    elsif key == :pomeranians || key == :goldfish
      unless @clues[attribute[0].to_sym] > attribute[1]
        match = false
      end
    else
      unless @clues[attribute[0].to_sym] == attribute[1]
        match = false
      end
    end
  end
  if match
    puts "Aunt #{number} is the winner!"
  end
end