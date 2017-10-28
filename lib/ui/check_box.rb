class CheckBox
  SIZE = 25

  attr_accessor :x, :y, :checked
  attr_reader :text

  def initialize(x, y, checked = false, size = CheckBox::SIZE)
    @x, @y = x, y
    @checked = checked
    @size = size
    @text = Text.new("✔", false, x: x, y: y, size: size, color: Gosu::Color::BLACK, shadow: true)
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
    $window.fill_rect(@x, @y, width, height, Gosu::Color::BLACK)
    if mouse_over?
      $window.fill_rect(@x+1, @y+1, width-2, height-2, Input::FOCUS_BACKGROUND_COLOR)
    else
      $window.fill_rect(@x+1, @y+1, width-2, height-2, Input::NO_FOCUS_BACKGROUND_COLOR)
    end
    if @checked
      @text.draw
    end
  end

  def update
    @text.x = @x+BUTTON_PADDING
    @text.y = @y+BUTTON_PADDING
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

  def width(text_object = @text)
    text_object.textobject.text_width(text_object.text)+BUTTON_PADDING*2
  end

  def height(text_object = @text)
    text_object.textobject.height+BUTTON_PADDING*2
  end
end
