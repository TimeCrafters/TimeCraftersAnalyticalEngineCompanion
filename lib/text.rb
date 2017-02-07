class Text
  attr_accessor :text, :x, :y, :z, :size, :factor_x, :factor_y, :color, :options
  attr_reader :textobject
  def initialize(text, auto_manage = true, options={})
    @text = text || ""
    @options = options
    @size = options[:size] || 14
    @font = options[:font] || Gosu.default_font_name
    @x = options[:x] || 0
    @y = options[:y] || 0
    @z = options[:z] || 1025
    @factor_x = options[:factor_x] || 1
    @factor_y = options[:factor_y] || 1
    @color    = options[:color] || Gosu::Color::WHITE
    @textobject = Gosu::Font.new(@size, name: @font)

    Window.instance.elements.push(self) if auto_manage
  end

  def width
    textobject.text_width(@text)
  end

  def height
    textobject.height
  end

  def draw
    @textobject.draw(@text, @x, @y, @z, @factor_x, @factor_y, @color)
  end

  def update; end
end
