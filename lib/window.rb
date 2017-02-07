HEADER_COLOR = Gosu::Color.rgb(0, 200, 0)
BODY_COLOR   = Gosu::Color.rgb(200, 200, 200)#Gosu::Color.rgb(12,12,12)

class Window < Gosu::Window
  NAME = "TimeCrafters Analytical Engine"
  attr_reader :elements, :mouse

  def self.instance=(this)
    @instance = this
  end

  def self.instance
    @instance
  end

  def initialize
    Window.instance = self
    super(1000, 700, false)
    $window = self
    self.caption = NAME
    @elements = []
    @mouse = Mouse.new(0, 0)

    title = Text.new(NAME, true, size: 36, y: 20)
    Button.new("Scouting", 10, 60) do |i|
      i.text.text = "Hello"
    end
    Button.new("Autonomous", 120, 60)
    Button.new("TeleOp", 260, 60)

    Button.new("Sync", 925, 60)
    title.x = (Gosu.screen_width/4)-(title.textobject.text_width(NAME)/2)
  end

  def draw
    fill_rect(0, 0, self.width, 100, HEADER_COLOR)
    fill_rect(0, 100, self.width, self.height, BODY_COLOR)
    @elements.each(&:draw)
  end

  def update
    @mouse.x, @mouse.y = self.mouse_x, self.mouse_y
    @elements.each(&:update)
  end

  def button_up(id)
    @elements.each {|e| if defined?(e.button_up); e.button_up(id); end}
  end

  def needs_cursor?
    true
  end

  def fill_rect(x, y, width, height, color = Gosu::Color::WHITE, z = 0, mode = :default)
    return  draw_quad(x, y, color,
                      x, height+y, color,
                      width+x, height+y, color,
                      width+x, y, color,
                      z, mode)
  end
end
