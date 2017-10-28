class CheckBox
  SIZE = 25

  attr_accessor :x, :y, :checked
  attr_reader :width, :height, :text

  def initialize(x, y, checked = false, size = CheckBox::SIZE)
    @x, @y = x, y
    @checked = checked
    @size = size
    @text = Text.new("✔", false, x: x, y: y, size: size, color: Gosu::Color::BLACK, shadow: true)
    @width  = @text.width
    @height = @text.height
    return self
  end

  def x=(int)
    @x = int
    @text.x = int
  end

  def y=(int)
    @y = int
    @text.y = int
  end

  def draw
    if mouse_over?
      $window.fill_rect(@x-BUTTON_PADDING, @y-BUTTON_PADDING, width+(BUTTON_PADDING*2), height+(BUTTON_PADDING*2), Input::FOCUS_BACKGROUND_COLOR)
    else
      $window.fill_rect(@x-BUTTON_PADDING, @y-BUTTON_PADDING, width+(BUTTON_PADDING*2), height+(BUTTON_PADDING*2), Input::NO_FOCUS_BACKGROUND_COLOR)
    end
    if @checked
      @text.draw
    end
  end

  def update
  end

  def button_up(id)
    if mouse_over? && id == Gosu::MsLeft
      if @checked
        @checked = false
      else
        @checked = true
      end
    end
  end

  def mouse_over?
    if $window.mouse.x.between?(@x, @x+width)
      if $window.mouse.y.between?(@y, @y+height)
        true
      end
    end
  end
end
