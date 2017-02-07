class MainContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    text "TimeCrafters Analytical Engine Companion", 250, 10, 32

    button "8962", 250, 45 do
      AppSync.active_team(8962)
    end
    button "10432", 250, 90 do
      AppSync.active_team(10432)
    end

    text "© 2017 Cyberarm. Licensed under the MIT open source License.", 130, 550, 24
  end
end
