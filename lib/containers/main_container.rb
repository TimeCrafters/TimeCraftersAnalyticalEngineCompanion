class MainContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK
    _x = 10
    _y = 70
    _b = nil
    dataless_teams = 0
    AppSync.teams_list.each do |number, name|
      if AppSync.team_has_scouting_data?(number) or AppSync.team_has_match_data?(number)
        dataless_teams+=1
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

    if AppSync.teams_list.count == 0
      text "No Teams List File in #{Dir.pwd}/data", 0, 45, 32, BAD_COLOR, :center
    end
    if AppSync.teams_list.count >= dataless_teams && AppSync.teams_list.count != 0
      text "No Data for Teams", 0, 45, 32, BAD_COLOR, :center
    end

    if !(AppSync.teams_list.count >= dataless_teams && AppSync.teams_list.count != 0) or AppSync.teams_list.count != 0
      text "Select a Team", 0, 10, 32, Gosu::Color::BLACK, :center
    end
  end
end
