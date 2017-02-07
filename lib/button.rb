BUTTON_TEXT_COLOR        = Gosu::Color::WHITE
BUTTON_TEXT_ACTIVE_COLOR = Gosu::Color::BLACK
BUTTON_COLOR             = Gosu::Color.rgb(12,12,12)
BUTTON_HOVER_COLOR       = Gosu::Color::WHITE
BUTTON_TEXT_SIZE         = 20
BUTTON_PADDING           = 10

class Button
  attr_reader :text, :x, :y

  def initialize(text, x, y, auto_manage = true, &block)
    @text = Text.new(text, false, x: x, y: y, size: BUTTON_TEXT_SIZE, color: BUTTON_TEXT_COLOR)
    @x = x
    @y = y
    @block = Proc.new{yield(self)}

    Window.instance.elements.push(self) if auto_manage
  end

  def draw
    @text.draw
    $window.fill_rect(@x, @y, width, height, BUTTON_COLOR)
  end

  def update
    @text.x = @x+BUTTON_PADDING
    @text.y = @y+BUTTON_PADDING
  end

  def button_up(id)
    case id
    when Gosu::MsLeft
      click_check
    end
  end

  def click_check
    if $window.mouse.x.between?(@x, @x+width)
      if $window.mouse.y.between?(@y, @y+height)
        puts "Clicked: #{@text.text}"
        @block.call if @block.is_a?(Proc)
      end
    end
  end

  def width
    @text.textobject.text_width(@text.text)+BUTTON_PADDING*2
  end

  def height
    @text.textobject.height+BUTTON_PADDING*2
  end

  def update_text(string)
    @text.text = string
  end
end
