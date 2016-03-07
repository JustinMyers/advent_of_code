def iterate_game( s )
  output_array = []
  
  current_count = 0
  current_symbol = s[0]
  
  s.each_with_index do |c, i|
    if c == current_symbol
      current_count += 1
      if i == s.size - 1
        output_array << current_count
        output_array << current_symbol
      end
    else
      output_array << current_count
      output_array << current_symbol
      
      current_symbol = c
      current_count = 1
      if i == s.size - 1
        output_array << current_count
        output_array << current_symbol
      end
    end
  end
  
  output_array
end

seed = "1113222113"
seed_array = []
seed.each_char do |c|
  seed_array << c.to_i
end

50.times do 
  seed_array = iterate_game(seed_array)
end

puts seed_array.size