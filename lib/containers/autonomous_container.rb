class AutonomousContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK
    @matches = []

    text "Autonomous", 400, 10, 32, AUTONOMOUS_HEADER_COLOR

    if AppSync.team_has_match_data?
      a_y = 100
      text "Beacons Claimed", 250, a_y
      beacons_claimed = text "N/A", 650, a_y
      text "Beacons Missed", 250, a_y+22
      beacons_missed = text "N/A", 650, a_y+22
      text "Beacons Success Percentage", 250, a_y+44
      beacons_success_percentage = text "N/A", 650, a_y+44

      text "Particles Scored in Vortex", 250, a_y+88
      scored_in_vortex = text "N/A", 650, a_y+88
      text "Particles Scored in Corner", 250, a_y+110
      scored_in_corner = text "N/A", 650, a_y+110
      text "Particles Scored in Vortex Success Percentage", 250, a_y+132
      scored_in_vortex_success_percentage = text "N/A", 650, a_y+132
      text "Particles Scored in Corner Success Percentage", 250, a_y+154
      scored_in_corner_success_percentage = text "N/A", 650, a_y+154

      text "Parked Completely on Platform", 250, a_y+198
      parked_completely_on_platform = text "N/A", 650, a_y+198
      text "Parked Completely on Ramp", 250, a_y+220
      parked_completely_on_ramp = text "N/A", 650, a_y+220
      text "Parked on Platform", 250, a_y+242
      parked_on_platform = text "N/A", 650, a_y+242
      text "Parked on Ramp", 250, a_y+264
      parked_on_ramp = text "N/A", 650, a_y+264
      text "Missed Parking", 250, a_y+286
      missed_parking = text "N/A", 650, a_y+286
      text "Parking Success Percentage", 250, a_y+308
      parking_success_percentage = text "N/A", 650, a_y+308

      text "Capball on Floor", 250, a_y+352
      capball_on_floor = text "N/A", 650, a_y+352
      text "Capball Missed", 250, a_y+374
      capball_missed = text "N/A", 650, a_y+374
      text "Capball Success Percentage", 250, a_y+396
      capball_success_percentage = text "N/A", 650, a_y+396

      @matches = AppSync.team_match_data

      _x = 10
      @matches.each_with_index do |match, index|
        b = button "Match #{index+1}", _x, 50 do
          puts match.autonomous.scored_in_vortex
        end
        _x+=b.width+10
      end
    else
      if AppSync.team_name
        text "No match data for #{AppSync.team_name}", 50, 50, 32
      else
        text "No team selected.", 350, 50, 32
      end
    end
  end
end
