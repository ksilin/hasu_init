require 'hasu'

Hasu.load 'ball.rb'
Hasu.load 'paddle.rb'

class Game < Hasu::Window

  WIDTH = 640
  HEIGHT = 480


  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset
    @ball = Ball.new
    @paddle_left = Paddle.new(:left, true)
    @paddle_right = Paddle.new(:right)

    @score_left = 0
    @score_right = 0
    @font = Gosu::Font.new(self, 'Arial', 48)
  end

  def update
    @ball.move!

    if @ball.off_right?
      @score_left +=1
      @ball = Ball.new
    end

    if @ball.off_left?
      @score_right +=1
      @ball = Ball.new
    end

    if @paddle_left.ai?
      @paddle_left.ai_move! @ball
    else
      if button_down?(Gosu::KbW)
        @paddle_left.up!
      end
      if button_down?(Gosu::KbS)
        @paddle_left.down!
      end
    end

    if button_down?(Gosu::KbUp)
      @paddle_right.up!
    end
    if button_down?(Gosu::KbDown)
      @paddle_right.down!
    end

    if @ball.intersect?(@paddle_left)
      @ball.bounce_off_paddle!(@paddle_left)
    end
    if @ball.intersect?(@paddle_right)
      @ball.bounce_off_paddle!(@paddle_right)
    end

  end

  def draw
    @ball.draw self

    @paddle_left.draw self
    @paddle_right.draw self

    @font.draw(@score_left, 30, 30, 0)
    @font.draw(@score_right, WIDTH - 50, 30, 0)
  end
end

Game.run