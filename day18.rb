class Light
  attr_reader :glowing, :stuck
  attr_accessor :stuck

  def initialize( _glowing, _stuck = false )
    @glowing = _glowing
    @neighbors = []
    @stuck = _stuck
  end
  
  def turn_on
    @glowing = true
  end
  
  def turn_off
    @glowing = false unless stuck
  end
  
  def make_stuck
    turn_on
    @stuck = true
  end
  
  def update_status!
    if glowing 
      if !@neighbors.select { |n| n }.count.between?(2,3)
        turn_off
      end
    else
      if @neighbors.select { |n| n }.count == 3
        turn_on
      end
    end
  end
  
  # an array of booleans
  def become_aware_of_neighbors( array )
    @neighbors = array
  end
end

input = File.open('inputs/day18_input.txt')

rows = []

while line = input.gets
  new_row = []
  line.each_char do |c|
    if c == '#'
      new_row << Light.new(true)
    elsif c == '.'
      new_row << Light.new(false)
    end
  end
  rows << new_row
end

rows.first.first.make_stuck
rows.first.last.make_stuck
rows.last.first.make_stuck
rows.last.last.make_stuck

size = 100
rounds = 100

rounds.times do
  
  (0..size-1).each do |x|
    (0..size-1).each do |y|
      neighbors = []
      light = rows[x][y]
      [-1,0,1].each do |nx|
        [-1,0,1].each do |ny|
          unless (nx == 0 && ny == 0) || x + nx < 0 || y + ny < 0 || !rows[x + nx]
            neighbor_light = rows[x + nx][y + ny]
            if neighbor_light
              neighbors << neighbor_light.glowing
            end
          end
        end
      end
      light.become_aware_of_neighbors( neighbors )
    end
  end
  
  (0..size-1).each do |x|
    (0..size-1).each do |y|
      light = rows[x][y]
      light.update_status!
    end
  end

end

on_total = 0

rows.each do |row|
  row.each do |light|
    if light.glowing
      on_total += 1
    end
  end
end

puts "There are #{on_total} lights!"