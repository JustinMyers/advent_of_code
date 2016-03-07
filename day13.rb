# { "location1_location2" => distance } where locations are sorted alphabetically
@happiness_sums = {}

people = []

@possible_arrangements = []

def arrangement_happiness( arrangement )
  happiness = 0
  arrangement.each_with_index do |person, i|
    if arrangement[i + 1]
      person_1 = arrangement[i]
      person_2 = arrangement[i+1]
      
      seating_string = [person_1, person_2].sort.join('_')
      
      happiness += @happiness_sums[seating_string]
    else
      person_1 = arrangement[i]
      person_2 = arrangement[0]
      
      seating_string = [person_1, person_2].sort.join('_')
      
      happiness += @happiness_sums[seating_string]
    end
  end
  happiness
end

def every_combination( combination, remainder )
  if remainder.count > 0
    remainder.each do |element|
      every_combination( combination + [element], remainder - [element] )
    end
  else
    @possible_arrangements << combination
  end
end

input = File.open('inputs/day13_input.txt')

while line = input.gets
  strings = line.split
  person_1, gain, amount, person_2 = [strings[0], strings[2], strings[3].to_i, strings[10]]
  person_2.slice!(-1..person_2.length)
  
  distance_string = [person_1, person_2].sort.join('_')
  
  @happiness_sums[distance_string] ||= 0
  @happiness_sums[distance_string] += ( gain == 'lose' ? amount * -1 : amount )
  
  people += [person_1, person_2]
  people = people.uniq
end

people.each do |person|
  me = "Justin"
  distance_string = [me, person].sort.join('_')
  @happiness_sums[distance_string] = 0
end

people << "Justin"

every_combination( [], people )

puts @possible_arrangements.map { |r| arrangement_happiness(r) }.max