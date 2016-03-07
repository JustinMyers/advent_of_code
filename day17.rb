original_containers = [33,14,18,20,45,35,16,35,1,13,18,13,50,44,48,6,24,41,30,42]

containers = []

original_containers.each_with_index do |c, i|
  containers << [c,i]
end

@good_sets = []

@attempted_sets = {}

def collection( set, inventory, target_capacity )
  capacity = (set + [0]).map { |c| c[0] }.inject(:+)

  if capacity < target_capacity
    inventory.each do |i|
      new_inventory = inventory - [i]
      new_set = set + [i]
      
      set_string = new_set.map { |c| c[1] }.sort.join('_')
      unless @attempted_sets[set_string]
        @attempted_sets[set_string] = true
        collection(new_set, new_inventory, target_capacity)
      end
    end
  elsif capacity == target_capacity
    @good_sets << set
    puts "Yay > #{set.inspect}"
  else
    # puts "Whoops > #{set.inspect}"
  end
end

collection( [], containers, 150)

min = @good_sets.map { |s| s.size }.min

puts @good_sets.select { |s| s.size == min }.count