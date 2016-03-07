input = File.open('inputs/day19_input.txt')

replacement_rules = []
molecule = ""

while line = input.gets
  line.strip!
  if line.include?("=>")
    replacement_rules << line.split(" => ")
  else
    molecule = line
  end
end

# replacement_rules = [ ["H", "HO"], ["H", "OH"], ["O", "HH"], ["e", "H"], ["e", "O"] ]
# molecule = "HOHOHO"

def arrayize_string( string )
  output = []
  string.each_char do |c|
    output << c
  end
  output
end

replacement_rules.map! do |r|
  r.map { |s| arrayize_string(s) }
end

target_molecule = molecule

molecule = arrayize_string("e")

new_molecules = [molecule]

# replacement_rules.each do |rule|
#   from = rule[0]
#   to = rule[1]
#
#   molecule.each_with_index do |c, i|
#     if c == from.first
#       match = true
#       from.size.times do |from_index|
#         if molecule[i+from_index] != from[from_index]
#           match = false
#         end
#       end
#       if match
#         new_molecule = molecule.dup
#         new_molecule.slice!(i, from.length)
#         new_molecule.insert(i, *to)
#         new_molecules << new_molecule.join
#       end
#     end
#   end
# end

@old_keys = {}

tar_array = arrayize_string(target_molecule)
@r_count = tar_array.count("r")
@R_count = tar_array.count("R")
@n_count = tar_array.count("n")
@Y_count = tar_array.count("Y")

def is_okay( a )
   a.count("r") <= @r_count &&
   a.count("R") <= @R_count &&
   a.count("n") <= @n_count &&
   a.count("Y") <= @Y_count
end

def synthesize_molecules( molecules, rules, rounds, target )
  rounds = rounds + 1
  output_molecules = {}
  
  molecules.each do |molecule|
    rules.each do |rule|
      from = rule[0]
      to = rule[1]

      molecule.each_with_index do |c, i|
        if c == from.first
          match = true
          from.size.times do |from_index|
            if molecule[i+from_index] != from[from_index]
              match = false
              break
            end
          end
          if match
            new_molecule = molecule.dup
            new_molecule.slice!(i, from.length)
            new_molecule.insert(i, *to)

            if is_okay(new_molecule)
              m_string = new_molecule.join 
              unless @old_keys[m_string]
                @old_keys[m_string] ||= 1
                output_molecules[m_string] ||= new_molecule
              end
            end

          end
        end
      end
    end
  end
  
  if output_molecules[target]
    puts "Target found in #{rounds} changes."
  else
    puts "round #{rounds} complete!"
    puts "Processing #{output_molecules.size} molecules ..."
    # filer for good ones!
    synthesize_molecules(output_molecules.values, rules, rounds, target)
  end
end

synthesize_molecules( new_molecules, replacement_rules, 0, target_molecule )