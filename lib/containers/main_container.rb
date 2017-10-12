class MainContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    text "Select a Team", 0, 10, 32, Gosu::Color::BLACK, :center

    _x = 10
    _y = 70
    _b = nil
    AppSync.teams_list.each do |number, name|
      if AppSync.team_has_scouting_data?(number) or AppSync.team_has_match_data?(number)
        b = button("#{number}", _x, _y, "#{name}") do
          AppSync.active_team(number)
          $window.active_container = ScoutingContainer.new
        end

        if number == 10432; b.text.color = Gosu::Color.rgb(40, 100, 40); end
        _x+=b.width+20

        if _x > $window.width
          _x = 10
          _y+= 45
        end
      end
    end
  end
end
