#require 'game'

class Ball
  SIZE = 16

  attr_reader :x, :y, :angle, :speed

  def initialize
    @x = Game::WIDTH/2
    @y = Game::HEIGHT/2
    @angle = rand(120) + 30
    @angle *= -1 if rand > 0.5
    @speed = 4
  end

  def x1
    @x - SIZE/2
  end

  def x2
    @x + SIZE/2
  end

  def y1
    @y - SIZE/2
  end

  def y2
    @y + SIZE/2
  end

  def dy
    Gosu.offset_y(angle, speed)
  end

  def dx
    Gosu.offset_x(angle, speed)
  end

  def intersect?( paddle)
    x2 > paddle.x1 && x1 < paddle.x2 &&
    y1 < paddle.y2 && y2 > paddle.y1
  end

  def move!
    @x += dx
    @y += dy

    if @y < 0
      y1 = 0
      bounce_off_walls!(dx, dy)
    end

    if @y > Game::HEIGHT
      y2 = Game::HEIGHT
      bounce_off_walls!(dx, dy)
    end

  end

  def bounce_off_walls!(dx, dy)
    @angle = Gosu.angle(0, 0, dx, -dy)
  end

  def bounce_off_paddle!(paddle)
    @angle = Gosu.angle(0, 0, -dx, dy)
    @speed *= 1.05
  end


  def draw(window)

    color = Gosu::Color::RED

    window.draw_quad(
        x1, y1, color,
        x2, y1, color,
        x2, y2, color,
        x1, y2, color
    )
  end

  def off_right?
    x2 > Game::WIDTH
    end

  def off_left?
    x1 < 0
  end
end