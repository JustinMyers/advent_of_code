input = File.open('inputs/day5_input.txt')

nice_count = 0

# while line = input.gets
#   is_nice = true
#
#   unless /[aeiou].*[aeiou].*[aeiou]/ =~ line
#     is_nice = false
#     puts "#{line} failed test 1."
#   end
#
#   unless /(.)\1{1}/ =~ line
#     is_nice = false
#     puts "#{line} failed test 2."
#   end
#
#   if /ab|cd|pq|xy/ =~ line
#     is_nice = false
#     puts "#{line} failed test 3."
#   end
#
#   nice_count += 1 if is_nice
# end

while line = input.gets
  is_nice = true

  unless /([a-z]{2}).*\1/ =~ line
    is_nice = false
    puts "#{line} failed test 1."
  end
  
  unless /([a-z]).\1/ =~ line
    is_nice = false
    puts "#{line} failed test 2."
  end

  nice_count += 1 if is_nice
end

puts "There are #{nice_count} nice strings."