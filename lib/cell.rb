
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