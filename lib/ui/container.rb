class Container

  attr_accessor :text_color
  attr_reader :elements, :x, :y, :width, :height, :options
  attr_reader :scroll_x, :scroll_y

  def initialize(x = 0, y = 100, width = Gosu.screen_width, height = Gosu.screen_height-100, options = {})
    @x, @y, @width, @height = x, y, width, height
    @scroll_x, @scroll_y = 0, 0
    @scroll_speed = 10

    @options = {}
    @text_color = Text::COLOR
    @elements = []

    if defined?(self.setup); setup; end
  end

  def draw
    Gosu.clip_to(x, y, width, height) do
      Gosu.translate(scroll_x, scroll_y) do
        @elements.each(&:draw)
      end
    end
  end

  def update
    @elements.each(&:update)
  end

  def button_up(id)
    case id
    when Gosu::MsWheelDown
      @scroll_y+=@scroll_speed
      @scroll_y = 0 if @scroll_y > 0
      @elements.each {|e| e.set_offset(@scroll_x, @scroll_y) if e.is_a?(Button) }
    when Gosu::MsWheelUp
      @scroll_y-=@scroll_speed
      if height-$window.height > 0
        @scroll_y = 0
      else
        @scroll_y = height-$window.height if @scroll_y <= height-$window.height
      end

      @elements.each {|e| e.set_offset(@scroll_x, @scroll_y) if e.is_a?(Button) }
    end

    @elements.each {|e| if defined?(e.button_up); e.button_up(id); end}
  end

  def build(&block)
    yield(self)
  end

  def text(text, x, y, size = Text::SIZE, color = self.text_color)
    relative_x = @x+x
    relative_y = @y+y
    _text      = Text.new(text, false, x: relative_x, y: relative_y, size: size, color: color)
    @elements.push(_text)

    return _text
  end

  def button(text, x, y, &block)
    relative_x = @x+x
    relative_y = @y+y
    _button    = Button.new(text, relative_x, relative_y, false) { block.call }
    @elements.push(_button)

    return _button
  end

  def fill_rect(x, y, width, height, color = BODY_COLOR, z = 0)
    $window.fill_rect(x, y, width, height, color)
  end

  def fill(color = BODY_COLOR, z = 0)
    fill_rect(@x, @y, @width, @height, color, z)
  end
end
