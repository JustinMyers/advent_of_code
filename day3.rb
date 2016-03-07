# x = 0
# y = 0
#
# houses_visited = {"0_0" => 1}
#
# input = File.open('inputs/day3_input.txt').gets
#
# input.each_char do |instruction|
#   case instruction
#   when 'v'
#     y -= 1
#   when '^'
#     y += 1
#   when '<'
#     x -= 1
#   when '>'
#     x += 1
#   end
#
#   houses_visited["#{x}_#{y}"] ||= 0
#   houses_visited["#{x}_#{y}"] += 1
# end
#
# puts "#{houses_visited.count} unique houses were visited by Santa"

santa_x = 0
santa_y = 0

robot_x = 0
robot_y = 0

houses_visited = { "0_0" => 2 }

santas_turn = true

input = File.open('inputs/day3_input.txt').gets

input.each_char do |instruction|
  case instruction
  when 'v'
    ( santas_turn ? santa_y -= 1 : robot_y -= 1 )
  when '^'
    ( santas_turn ? santa_y += 1 : robot_y += 1 )
  when '<'
    ( santas_turn ? santa_x -= 1 : robot_x -= 1 )
  when '>'
    ( santas_turn ? santa_x += 1 : robot_x += 1 )
  end
  
  house_string = ( santas_turn ?  "#{santa_x}_#{santa_y}" : "#{robot_x}_#{robot_y}" )
  
  houses_visited[house_string] ||= 0
  houses_visited[house_string] += 1
  
  santas_turn = !santas_turn
end

puts "#{houses_visited.count} unique houses were visited by the team"