file_input = File.open('inputs/day12_input.txt').gets

def get_list_kind( c )
  if c == '{'
    'object'
  elsif c == '['
    'array'
  end
end

def carve_red_objects( input )
  open_chars = []

  current_list = ""

  red_found = false

  destroy_ranges = []

  (0..input.size - 1).each do |i|
    break if !destroy_ranges.empty?
  
    if input[i] == '{'
      open_chars << [input[i], i]
      current_list = 'object'
    end
  
    if input[i] == '['
      open_chars << [input[i], i]
      current_list = 'array'
    end
  
    if input[i] == 'r' && input[i+1] == 'e' && input[i+2] == 'd' && current_list == 'object'
      red_found = true
    end
  
    if input[i] == ']'
      open_chars.pop
      current_list = if open_chars.empty?
        nil
      else
        get_list_kind( open_chars.last[0] ) 
      end
    end  
  
    if input[i] == '}'
      start = open_chars.pop
      current_list = if open_chars.empty?
        nil
      else
        get_list_kind( open_chars.last[0] ) 
      end
      if red_found
        destroy_ranges << [start[1], i]
        red_found = false
      end
    end
  end
  
  if destroy_ranges[0]
    range = destroy_ranges.first
    input.slice!(range[0]..range[1])
  end
    
  input
end

original = file_input
cut = carve_red_objects( original.dup )
until( original == cut ) do
  original = cut
  cut = carve_red_objects( original.dup )
end

current_number = ""
total = 0

cut.each_char do |c|
  if c == '-'
    current_number << c
  elsif c =~ /[0-9]/
    current_number << c
  else
    total += current_number.to_i
    current_number = ""
  end
end

puts total