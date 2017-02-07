class MainContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    text "TimeCrafters Analytical Engine Companion", 250, 10, 32

    _x = 10
    _y = 70
    AppSync.teams_list.each do |number, name|
      b = button("#{number}", _x, _y) do
        AppSync.active_team(number)
      end
      _x+=b.width+100

      if _x > 950
        _x = 10
        _y+= 45
      end
    end

    text "© 2017 Cyberarm. Licensed under the MIT open source License.", 130, 550, 24
  end
end
