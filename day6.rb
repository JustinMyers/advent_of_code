input = File.open('inputs/day6_input.txt')

@lights = {}

def turn_on(coord)
  @lights[coord] += 1
end

def turn_off(coord)
  @lights[coord] = [0, @lights[coord] - 1].max
end

def toggle(coord)
  turn_on(coord)
  turn_on(coord)
end

def install_bulb(coord)
  @lights[coord] ||= 0
end

while line = input.gets
  instruction, x1, y1, x2, y2 = line.match(/^(turn on|turn off|toggle) (\d*),(\d*) through (\d*),(\d*)/).captures
  x1, y1, x2, y2 = [x1, y1, x2, y2].map(&:to_i)
  
  (x1..x2).each do |x|
    (y1..y2).each do |y|
      coordinate = "#{x}_#{y}"
      install_bulb(coordinate)
      
      # puts "#{instruction}: #{x},#{y}"
      
      case instruction
      when "turn on"
        turn_on(coordinate)
      when "turn off"
        turn_off(coordinate)
      when "toggle"
        toggle(coordinate)
      end
    end
  end

end

total_brightness = @lights.values.inject(:+)

puts "The grid is #{total_brightness} lumens."

# input = File.open('inputs/day6_input.txt')
#
# @lights = {}
#
# def turn_on(coord)
#   @lights[coord] = "on"
# end
#
# def turn_off(coord)
#   @lights[coord] = "off"
# end
#
# def toggle(coord)
#   if @lights[coord] == "on"
#     turn_off(coord)
#   elsif @lights[coord] == "off"
#     turn_on(coord)
#   end
# end
#
# def install_bulb(coord)
#   turn_off(coord) unless @lights[coord]
# end
#
# while line = input.gets
#   instruction, x1, y1, x2, y2 = line.match(/^(turn on|turn off|toggle) (\d*),(\d*) through (\d*),(\d*)/).captures
#   x1, y1, x2, y2 = [x1, y1, x2, y2].map(&:to_i)
#
#   (x1..x2).each do |x|
#     (y1..y2).each do |y|
#       coordinate = "#{x}_#{y}"
#       install_bulb(coordinate)
#
#       # puts "#{instruction}: #{x},#{y}"
#
#       case instruction
#       when "turn on"
#         turn_on(coordinate)
#       when "turn off"
#         turn_off(coordinate)
#       when "toggle"
#         toggle(coordinate)
#       end
#     end
#   end
#
# end
#
# lights_lit = @lights.values.select { |l| l == "on" }.count
#
# puts "There are #{lights_lit} lights lit."