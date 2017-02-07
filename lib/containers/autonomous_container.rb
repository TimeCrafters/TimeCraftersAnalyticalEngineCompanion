class AutonomousContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    text "O O", 0, 0
    text "   |", 0, 20
    text "\\__/", 0, 40
  end
end
