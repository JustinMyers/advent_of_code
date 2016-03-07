require 'digest'

input = "ckczppom%d"

hash_found = false

i = 1

while !hash_found
  md5 = Digest::MD5.hexdigest( input % i )
  
  break if /^000000/ =~ md5
  
  i += 1
end

puts i