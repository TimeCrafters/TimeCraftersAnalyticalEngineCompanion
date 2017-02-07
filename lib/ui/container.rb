class Container

  attr_accessor :text_color
  attr_reader :elements, :x, :y, :width, :height, :options

  def initialize(x = 0, y = 100, width = Gosu.screen_width, height = Gosu.screen_height-100, options = {})
    @x, @y, @width, @height = x, y, width, height
    @options = {}
    @text_color = Text::COLOR
    @elements = []

    if defined?(self.setup); setup; end
  end

  def draw
    Gosu.clip_to(x, y, width, height) do
      @elements.each(&:draw)
    end
  end

  def update
    @elements.each(&:update)
  end

  def button_up(id)
    @elements.each {|e| if defined?(e.button_up); e.button_up(id); end}
  end

  def build(&block)
    yield(self)
  end

  def text(text, x, y, size = Text::SIZE, color = self.text_color)
    relative_x = @x+x
    relative_y = @y+y
    @elements.push(Text.new(text, false, x: relative_x, y: relative_y, size: size, color: color))
  end

  def button(text, x, y, &block)
    relative_x = @x+x
    relative_y = @y+y
    @elements.push(Button.new(text, relative_x, relative_y, false) { block.call })
  end

  def fill_rect(x, y, width, height, color = BODY_COLOR, z = 0)
    $window.fill_rect(x, y, width, height, color)
  end

  def fill(color = BODY_COLOR, z = 0)
    fill_rect(@x, @y, @width, @height, color, z)
  end
end
