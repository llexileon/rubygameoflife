class World
  attr_reader :rows, :cols, :grid, :cells

  def initialize(rows = 3, cols = 3)
    @rows = rows
    @cols = cols

    @grid = Array.new(rows) do |row|
              Array.new(cols) do |col|
                Cell.new(row, col)
              end
            end

    @cells = grid.flatten
  end

  def live_cells
    cells.select { |cell| cell.alive? }
  end

  def live_neighbors_of(cell)
    live = []
    x, y = cell.x, cell.y
    neighbors = [*x - 1..x + 1].product([*y - 1..y + 1])
      .reject { |c| c == [x, y] }

    neighbors.each do |neighbor|
      x, y = neighbor[0], neighbor[1]
      next if x < 0 || x >= rows || y < 0 || y >= cols
      live << [x, y] if grid[x][y].alive?
    end

    live
  end

  def randomly_populate
    cells.each do |cell|
      cell.alive = [true, false].sample
    end
  end
end

class Cell
  attr_reader :x, :y
  attr_accessor :alive

  def initialize(x = 0, y = 0)
    @x, @y = x, y
    @alive = false
  end

  def alive?
    alive
  end

  def dead?
    !alive
  end

  def lives
    @alive = true
  end

  def dies
    @alive = false
  end
end

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