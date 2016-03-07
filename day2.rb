input = File.open('./inputs/day2_input.txt')

total_paper = 0

total_ribbon = 0

while line = input.gets
  package_dimensions = line.split('x').map(&:to_i)
  
  sides_area = [
    package_dimensions[0] * package_dimensions[1],
    package_dimensions[0] * package_dimensions[2],
    package_dimensions[1] * package_dimensions[2]
  ]
  
  smallest_side = sides_area.min
  
  total_paper += sides_area.map { |s| s*2 }.inject(:+) + smallest_side
  
  sides_perimeter = [
    package_dimensions[0] * 2 + package_dimensions[1] * 2,
    package_dimensions[0] * 2 + package_dimensions[2] * 2,
    package_dimensions[1] * 2 + package_dimensions[2] * 2
  ]
  
  smallest_perimeter = sides_perimeter.min
  
  package_volume = package_dimensions.inject(:*)
  
  total_ribbon += smallest_perimeter + package_volume
end

puts "The elves need #{total_paper} sq. ft. of paper"
puts "The elves need #{total_ribbon} ft. of ribbon"