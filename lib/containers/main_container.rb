class MainContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    text "TimeCrafters Analytical Engine Companion", 250, 10, 32
    text "© 2017 Cyberarm. Licensed under the MIT open source License.", 130, 550, 24
  end
end
