# this is the solution to part 2.

input = File.open('inputs/day8_input.txt')

input_parsed = []

input.each_byte do |b|
  input_parsed << b
end

code = 0
memory = 0

total_code = []
total_memory = []

escaping = false

escape_until = 0

input_parsed.each_with_index do |b, i|
  if b == 10 # add to total and reset the counts
    total_code << code
    total_memory << memory
    
    code = 0
    memory = 0
  else
    memory += 1
    
    if b == 34 && !escaping
      code += 3
    elsif escaping and i == escape_until
      escaping = false
    elsif b == 92 and !escaping
      escaping = true
      escaped_byte = input_parsed[i+1]
      if escaped_byte == 120
        code += 5
        escape_until = i + 3
      else
        if escaped_byte == 92 || escaped_byte == 34
          code += 4
        else
          code += 3
        end
        escape_until = i + 1
      end
    elsif b != 34 && !escaping
      code += 1
    end
  end  
end

puts "code: #{total_code.inject(:+)}"
puts "memory: #{total_memory.inject(:+)}"

puts total_code.inject(:+) - total_memory.inject(:+)

# This is the solution to part 1

# ha ha, remember to add a fucking newline, dummy.

# input = File.open('inputs/day8_input.txt')
#
# input_parsed = []
#
# input.each_byte do |b|
#   input_parsed << b
# end
#
# code = 0
# memory = 0
#
# total_code = []
# total_memory = []
#
# escaping = false
#
# escape_until = 0
#
# input_parsed.each_with_index do |b, i|
#   if b == 10 # add to total and reset the counts
#     total_code << code
#     total_memory << memory
#
#     code = 0
#     memory = 0
#   else
#     code += 1
#
#     if escaping and i == escape_until
#       memory += 1
#       escaping = false
#     elsif b == 92 and !escaping
#       escaping = true
#       escaped_byte = input_parsed[i+1]
#       if escaped_byte == 120
#         escape_until = i + 3
#       else
#         escape_until = i + 1
#       end
#     elsif b != 34 && !escaping
#       memory += 1
#     end
#   end
# end
#
# puts total_code.inject(:+) - total_memory.inject(:+)