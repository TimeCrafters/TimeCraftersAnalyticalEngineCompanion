class MainContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    text "TimeCrafters Analytical Engine Companion", 250, 10, 32
    text "Select team: ", 250, 42

    _x = 10
    _y = 70
    _b = nil
    AppSync.teams_list.each do |number, name|
      b = button("#{number}", _x, _y) do
        AppSync.active_team(number)
      end

      if number == 10432; b.text.color = Gosu::Color.rgb(40, 100, 40) ; end
      _x+=b.width+20

      if _x > 900
        _x = 10
        _y+= 45
      end
    end

    text "© 2017 Cyberarm. Licensed under the MIT open source License.", 130, 550, 24
  end
end
