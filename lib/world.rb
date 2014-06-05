
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