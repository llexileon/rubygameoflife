#!/usr/bin/env ruby -w

require 'gosu'
require './lib/lifelogic'

class GameWindow < Gosu::Window

  attr_reader :width, :height, :game, :dx, :dy, :cols, :rows, :tone, :text

  def initialize(width, height)

    @width, @height = width, height
    super(width, height, false)
    self.caption = "The Game of Life"
    @dx, @dy = 10, 10
    @cols, @rows = width / dx, height / dy
    @gen = 1

    @tone = Gosu::Sample.new(self, './assets/audio/csample.mp3')
    @text = Gosu::Font.new(self, './assets/victor-pixel.ttf', 32)

    @game = Game.new(World.new(@rows, @cols))
    reset_game
  end

  def reset_game
    @gen = 0 
    @alivecol = Gosu::Color::FUCHSIA
    @deadcol = Gosu::Color::BLACK
    @game.world.randomly_populate
  end
 
  def update
    game.tick
    @gen += 1
  end

  def draw
    game.world.cells.each do |cell|
      col, row = cell.y, cell.x
      color = cell.alive? ? @alivecol : @deadcol
      color.hue = "#{@transition}".to_i

      draw_quad(  col * dx, row * dy + 40,     color,
        (col + 1) * dx - 1, row * dy + 40,      color,
                  col * dx, (row + 1) * dy + 40, color,
        (col + 1) * dx - 1, (row + 1) * dy + 40, color)
    end

    live_cells = game.world.live_cells.count
    speed = 100 * live_cells / (cols * rows)
    @transition = speed * 10

    text.draw("Gen: #{@gen}", 50, 0, 50, 1, 1)
    text.draw("Live cells: #{live_cells}", 275, 0, 50, 1, 1)
    text.draw("Pitch: #{speed}", 620, 0, 50, 1, 1)
    tone.play(10, speed) 
  end

  def button_down(id)
    case id
    when Gosu::KbSpace  # space bar restarts game
      reset_game
    when Gosu::KbQ # Q key quits
      close
    end
  end

  def needs_cursor?
    true
  end
end

GameWindow.new(800, 450).show