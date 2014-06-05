
class Game
  attr_reader :world, :seeds
  def initialize(world = World.new, seeds = [])
    @world = world
    @seeds = seeds
    seeds.each do |seed|
      world.grid[seed[0]][seed[1]].lives
    end
  end

  def tick
    next_live_cells, next_dead_cells = [], []

    world.cells.each do |cell|
      neighbors = world.live_neighbors_of(cell).count
      if cell.alive?
        next_dead_cells << cell if neighbors < 2
        next_live_cells << cell if neighbors.between?(2, 3)
        next_dead_cells << cell if neighbors > 3
      else
        next_live_cells << cell if neighbors == 3
      end
    end

    next_dead_cells.each { |cell| cell.dies }
    next_live_cells.each { |cell| cell.lives }
  end
end