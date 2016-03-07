def is_valid_password?(password)
  valid = true
  
  char_array = []
  password.each_char { |c| char_array << c }
    
  if valid
    has_bad_letters = false
    char_array.each do |c|
      has_bad_letters = true if c == "i" || c == "o" || c == "l"
      break if has_bad_letters
    end
    valid = false if has_bad_letters
    
    puts "failed letter test" unless valid
  end
  
  if valid
    valid = false unless has_two_pairs?(char_array)
    
    puts "failed pair test" unless valid
  end
  
  if valid
    valid = false unless has_incrementing_sequence?(char_array)

    puts "failed incrementing test" unless valid
  end
  
  valid
end

def has_incrementing_sequence?(password)
  has_sequence = false

  password.each_with_index do |c, i|
    break if i == password.size - 2
    if password[i+1] == (c2 = c.next)
      if password[i+2] == c2.next
        has_sequence = true
      end
    end
  end
  
  has_sequence
end

def has_two_pairs?(password)
  pairs = []

  password.each_with_index do |c, i|
    pairs << [c,c] if password[i+1] == c
  end
  
  pairs.uniq.count > 1
end

# input = "hepxcrrq"
input = "hepxxyzz".next

until is_valid_password?( input )
  puts input
  input = input.next
end

puts input