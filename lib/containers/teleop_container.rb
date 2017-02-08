class TeleOpContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK
    @matches = []

    text "TeleOp", 430, 10, 32, TELEOP_HEADER_COLOR

    if AppSync.team_has_match_data?
      set_layout_y(100, 22)

      text "Beacons Claimed", 250, layout_y(true)
      beacons_claimed = text "N/A", 650, layout_y
      text "Beacons Missed", 250, layout_y(true)
      beacons_missed = text "N/A", 650, layout_y
      text "Beacons Success Percentage", 250, layout_y(true)
      beacons_success_percentage = text "N/A", 650, layout_y
      layout_y

      text "Particles Scored in Vortex", 250, layout_y(true)
      scored_in_vortex = text "N/A", 650, layout_y
      text "Particles Missed Vortex", 250, layout_y(true)
      missed_vortex = text "N/A", 650, layout_y
      text "Particles Scored in Corner", 250, layout_y(true)
      scored_in_corner = text "N/A", 650, layout_y
      text "Particles Missed Corner", 250, layout_y(true)
      missed_corner = text "N/A", 650, layout_y
      text "Particles Scored in Vortex Success Percentage", 250, layout_y(true)
      scored_in_vortex_success_percentage = text "N/A", 650, layout_y
      text "Particles Scored in Corner Success Percentage", 250, layout_y(true)
      scored_in_corner_success_percentage = text "N/A", 650, layout_y
      layout_y

      text "Capball off Floor", 250, layout_y(true)
      capball_off_floor = text "N/A", 650, layout_y
      text "Capball Above Crossbar", 250, layout_y(true)
      capball_above_crossbar = text "N/A", 650, layout_y
      text "Capball Capped", 250, layout_y(true)
      capball_capped = text "N/A", 650, layout_y
      text "Capball Missed", 250, layout_y(true)
      capball_missed = text "N/A", 650, layout_y
      text "Capball Success Percentage", 250, layout_y(true)
      capball_success_percentage = text "N/A", 650, layout_y
      layout_y

      text "Dead Robot", 250, layout_y(true)
      dead_robot = text "N/A", 650, layout_y

      @matches = AppSync.team_match_data

      _x = 10
      @matches.each_with_index do |match, index|
        b = button "Match #{index+1}", _x, 50 do
          beacons_claimed.text = match.teleop.beacons_claimed.to_s
          beacons_missed.text = match.teleop.beacons_missed.to_s
          beacons_success_percentage.text = calc_percentage(match.teleop.beacons_claimed, match.teleop.beacons_claimed+match.teleop.beacons_missed)

          scored_in_vortex.text = match.teleop.scored_in_vortex.to_s
          scored_in_corner.text = match.teleop.scored_in_corner.to_s
          missed_vortex.text = match.teleop.missed_vortex.to_s
          missed_corner.text = match.teleop.missed_corner.to_s
          scored_in_vortex_success_percentage.text = calc_percentage(match.teleop.scored_in_vortex, match.teleop.scored_in_vortex+match.teleop.missed_vortex)
          scored_in_corner_success_percentage.text = calc_percentage(match.teleop.scored_in_corner, match.teleop.scored_in_corner+match.teleop.missed_corner)

          capball_off_floor.text = match.teleop.capball_on_floor.to_s
          capball_above_crossbar.text = match.teleop.capball_above_crossbar.to_s
          capball_capped.text = match.teleop.capball_capped.to_s
          capball_missed.text = match.teleop.capball_missed.to_s
          capball_success_percentage.text = calc_percentage(match.teleop.capball_off_floor+match.teleop.capball_above_crossbar+match.teleop.capball_capped, match.teleop.capball_off_floor+match.teleop.capball_above_crossbar+match.teleop.capball_capped+match.teleop.capball_missed)

          if match.teleop.is_dead_robot
            dead_robot.text = "Yes"
            dead_robot.color= BAD_COLOR
          else
            dead_robot.text = "No"
            dead_robot.color= GOOD_COLOR
          end
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
