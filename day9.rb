# { "location1_location2" => distance } where locations are sorted alphabetically
@distances = {}

destinations = []

@possible_routes = []

min_route_distance = 99999999999999999999

def route_distance( route )
  distance = 0
  route.each_with_index do |destination, i|
    if route[i + 1]
      dest_1 = route[i]
      dest_2 = route[i+1]
      
      distance_string = [dest_1, dest_2].sort.join('_')
      
      distance += @distances[distance_string]
    end
  end
  distance
end

def every_combination( combination, remainder )
  if remainder.count > 0
    remainder.each do |element|
      every_combination( combination + [element], remainder - [element] )
    end
  else
    @possible_routes << combination
  end
end

input = File.open('inputs/day9_input.txt')

while line = input.gets
  strings = line.split
  location_1, location_2, distance = [strings[0], strings[2], strings[4].to_i]
  distance_string = [location_1, location_2].sort.join('_')
  @distances[distance_string] = distance
  destinations += [location_1, location_2]
  destinations = destinations.uniq
end

every_combination( [], destinations )

puts @possible_routes.map { |r| route_distance(r) }.max