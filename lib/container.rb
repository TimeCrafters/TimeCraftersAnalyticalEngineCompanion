class Container
  def initialize(x, y, width, height)
  end

  def build(&block)
    block.call
  end
end
