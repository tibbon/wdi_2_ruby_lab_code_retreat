class Cell

  include Comparable

  def initialize(status: :dead)
    @status = status
  end

  def status
    @status
  end

  def survive(alive_neighbors:)
    if status == :alive
      if alive_neighbors < 2
        new_dead_cell
      elsif alive_neighbors > 3
        new_dead_cell
      else
        new_alive_cell
      end
    else
      if alive_neighbors == 3
        new_alive_cell
      else
        new_dead_cell
      end
    end
  end

  def <=>(other)
    status <=> other.status
  end

  private
  def new_alive_cell
    Cell.new(status: :alive)
  end

  def new_dead_cell
    Cell.new()
  end
end

class World
  def initialize(dimensions: 64, cells: [])
    if cells.length < 1
      @cells = Array.new(dimensions) {
        Array.new(dimensions) { Cell.new }
      }
    else
      @cells = cells
    end
  end

  def cells
    @cells
  end

  def next_world
    # map each cell, count alive neighbors
    # tell each cell how many alive neighbors it has
    # Create a new world from those results
    World.new()
  end

  private

  def count_alive_neighbors(cell)
  end
end
