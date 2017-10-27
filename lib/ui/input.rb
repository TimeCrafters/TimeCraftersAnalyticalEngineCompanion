class Input
  WIDTH = 200
  FOCUS_BACKGROUND_COLOR = Gosu::Color::RED
  NO_FOCUS_BACKGROUND_COLOR = Gosu::Color::GRAY

  attr_accessor :text, :x, :y, :width, :size, :color, :type, :focus
  attr_reader :text_object, :text_input, :height, :fixed_x

  def initialize(text, x, y, width = WIDTH, size = Text::SIZE, color = Gosu::Color::BLACK, tooltip = "", type = nil)
    @text = text
    @x, @y= x, y
    @width= width
    @size = size
    @color= color
    @tooltip=tooltip
    @type = type

    @focus = false

    @text_object = Text.new(text, false, x: x, y: y, size: size, color: color, shadow: true)
    @height      = @text_object.height
    @text_input  = Gosu::TextInput.new
    @text_input.text = @text

    @background_color = NO_FOCUS_BACKGROUND_COLOR
    @fixed_x = @x
    @x_offset= 0

    @carot_ticks = 0
    @carot_width = 2.5
    @carot_height= @text_object.height
    @carot_color = Gosu::Color::GREEN
    @carot_show_ticks = 25
    @show_carot  = true

    return self
  end

  def text=(string)
    @text = string
    @text_input.text, @text_object.text = @text, @text
  end

  def draw
    $window.fill_rect(x-BUTTON_PADDING, y-BUTTON_PADDING, width+BUTTON_PADDING, @text_object.height+BUTTON_PADDING, @background_color)
    Gosu.clip_to(x, y, width, @text_object.height) do
      @text_object.draw

      # Carot (Cursor)
      $window.fill_rect((@x+@text_object.width)-@x_offset, @y, @carot_width, @carot_height, @carot_color) if @show_carot && @focus
    end

  end

  def update
    if (@text_object.width+@carot_width)-@width >= 0
      @x_offset = (@text_object.width+@carot_width)-@width
    else
      @x_offset = 0
    end

    @text     = @text_object.text
    @carot_ticks+=1
    if @carot_ticks >= @carot_show_ticks
      if @show_carot
        @show_carot = false
      else
        @show_carot = true
      end

      @carot_ticks = 0
    end

    if @focus
      @text_object.text = @text_input.text
      $window.text_input = @text_input unless $window.text_input == @text_input
    end

    if mouse_over? && $window.button_down?(Gosu::MsLeft)
      @focus = true
      @background_color = FOCUS_BACKGROUND_COLOR
    end
    if !mouse_over? && $window.button_down?(Gosu::MsLeft)
      @focus = false
      $window.text_input = nil
      @background_color = NO_FOCUS_BACKGROUND_COLOR
    end

    if @text_object.width >= @width
      @text_object.x = self.fixed_x-@x_offset
    else
      @text_object.x = self.fixed_x
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
