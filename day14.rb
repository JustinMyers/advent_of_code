input = File.open('inputs/day14_input.txt')

reindeer = []

class Reindeer
  attr_accessor :name, :speed, :duration, :sleep
  
  def initialize( _name, _speed, _duration, _sleep )
    @name = _name
    @speed = _speed
    @duration = _duration
    @sleep = _sleep
  end
  
  def distance_traveled(time)
    distance = 0 
    
    sprint = duration + sleep
    
    distance += time / sprint * speed * duration
    
    distance += [ time % sprint, duration ].min * speed
    
    distance
  end
end

while line = input.gets
  line = line.split
  
  reindeer << Reindeer.new( line[0], line[3].to_i, line[6].to_i, line[13].to_i )
end

scores = {}

reindeer.each do |r|
  scores[r.name] = 0
end

2503.times do |x|
  time = x + 1
  leaders = []
  max_distance = 0
  
  race = {}

  reindeer.each do |r|
    distance = r.distance_traveled(time)
    race[distance] ||= []
    race[distance] << r.name
  end

  race[race.keys.max].each do |leader|
    scores[leader] += 1
  end
end

puts scores.inspect

# puts reindeer.map { |r| r.distance_traveled(2503) }.max