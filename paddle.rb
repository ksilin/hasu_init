class Paddle

  WIDTH = 16
  HEIGHT = 100

  SPEED = 4

  attr_reader :side, :ai, :x, :y
  alias ai? ai

  def initialize(side, ai = false)
    @side = side
    @ai = ai

    case side
      when :left
        @x = WIDTH
      when :right
        @x = Game::WIDTH - WIDTH
    end

    @y = Game::HEIGHT/2
  end

  def ai_move!(ball)
    if y < ball.y
      down!
    end
    if y > ball.y
      up!
    end
  end

  def x1
    @x - WIDTH/2
  end

  def x2
    @x + WIDTH/2
  end

  def y1
    @y - HEIGHT/2
  end

  def y2
    @y + HEIGHT/2
  end

  # TODO - limit paddles

  def up!
    @y -= SPEED
  end

  def down!
    @y += SPEED
  end

  def draw(window)

    color = Gosu::Color::GRAY

    window.draw_quad(
        x1, y1, color,
        x2, y1, color,
        x2, y2, color,
        x1, y2, color
    )
  end


end