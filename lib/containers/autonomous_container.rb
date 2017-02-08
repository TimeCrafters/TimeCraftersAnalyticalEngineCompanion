class AutonomousContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    text "O O", 0, 0
    text "   |", 0, 20
    text "\\__/", 0, 40
    MatchLoader.new("./data/3558/matches/-01486243343.json")
  end
end
