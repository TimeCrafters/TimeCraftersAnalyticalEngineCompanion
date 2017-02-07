class Container

  attr_reader :elements

  def initialize(x, y, width, height)
    @elements = []
  end

  def draw
    Gosu.clip(x, y, width, height) do
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
end
