class Ingredient
  attr_accessor :name, :capacity, :durability, :flavor, :texture, :calories
  
  def initialize( _name, _capacity, _durability, _flavor, _texture, _calories )
    @name = _name
    @capacity = _capacity
    @durability = _durability
    @flavor = _flavor
    @texture = _texture
    @calories = _calories
  end
end

input = File.open('inputs/day15_input.txt')

def strip_last(s)
  s.slice!(-1..s.length)
  s
end

@ingredients = []

while line = input.gets
  line = line.split
  
  name, capacity, durability, flavor, texture, calories = [
    strip_last(line[0]),
    strip_last(line[2]).to_i,
    strip_last(line[4]).to_i,
    strip_last(line[6]).to_i,
    strip_last(line[8]).to_i,
    line[10].to_i
  ]

  # puts [name, capacity, durability, flavor, texture, calories].inspect
  
  @ingredients << Ingredient.new(name, capacity, durability, flavor, texture, calories)
end

@mixtures = {}

def gimme_a_range( array )
  (0..array.inject(:-))
end

def loop_to_depth( depth, current, array )
  if current == depth
    n = array.inject(:-)
    a = array[1..array.length] + [n]
    @mixtures[a.join('_')] = a
  else
    gimme_a_range( array ).each do |v|
      loop_to_depth( depth, current + 1, array + [v] )
    end
  end
end

def integer_collections(total, length)
  loop_to_depth(length, 1, [total])
end

def calorie_cookie( sugar_q, sprinkles_q, candy_q, chocolate_q )
  sugar, sprinkles, candy, chocolate = @ingredients
  calories = [ sugar.calories * sugar_q + 
             sprinkles.calories * sprinkles_q + 
             candy.calories * candy_q + 
             chocolate.calories * chocolate_q, 0].max
  calories
end

def score_cookie( sugar_q, sprinkles_q, candy_q, chocolate_q )
  sugar, sprinkles, candy, chocolate = @ingredients
  capacity = [ sugar.capacity * sugar_q + 
             sprinkles.capacity * sprinkles_q + 
             candy.capacity * candy_q + 
             chocolate.capacity * chocolate_q, 0].max
  
  durability = [ sugar.durability * sugar_q + 
               sprinkles.durability * sprinkles_q + 
               candy.durability * candy_q + 
               chocolate.durability * chocolate_q, 0].max
               
  flavor = [ sugar.flavor * sugar_q + 
           sprinkles.flavor * sprinkles_q + 
           candy.flavor * candy_q + 
           chocolate.flavor * chocolate_q, 0].max
  
  texture = [ sugar.texture * sugar_q + 
            sprinkles.texture * sprinkles_q + 
            candy.texture * candy_q + 
            chocolate.texture * chocolate_q, 0].max

  texture * flavor * durability * capacity
end

integer_collections(100,4)

recipes = @mixtures.values

max_score = 0

recipes.each do |recipe|
  if calorie_cookie(*recipe) == 500
    score = score_cookie(*recipe)
    if score > max_score
      max_score = score
    end
  end
end

puts max_score