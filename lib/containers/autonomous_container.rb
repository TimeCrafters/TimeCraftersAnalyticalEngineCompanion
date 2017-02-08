class AutonomousContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK
    @matches = []

    if AppSync.team_has_match_data?
      @matches = AppSync.team_match_data

      _x = 10
      @matches.each_with_index do |match, index|
        b = button "Match #{index}", _x, 10 do
          puts match.autonomous.scored_in_vortex
        end
        _x+=b.width+10
      end
    else
      if AppSync.team_name
        text "No match data for #{AppSync.team_name}", 10, 10, 32
      else
        text "No team selected.", 10, 10, 32
      end
    end
  end
end
