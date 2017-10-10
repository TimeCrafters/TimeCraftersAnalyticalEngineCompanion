class AutonomousContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK
    @matches = []

    text "Autonomous", 400, 10, 32, AUTONOMOUS_HEADER_COLOR
    @matches = AppSync.team_match_data

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

      text "Parked Completely on Platform", 250, layout_y(true)
      parked_completely_on_platform = text "N/A", 650, layout_y
      text "Parked Completely on Ramp", 250, layout_y(true)
      parked_completely_on_ramp = text "N/A", 650, layout_y
      text "Parked on Platform", 250, layout_y(true)
      parked_on_platform = text "N/A", 650, layout_y
      text "Parked on Ramp", 250, layout_y(true)
      parked_on_ramp = text "N/A", 650, layout_y
      text "Missed Parking", 250, layout_y(true)
      missed_parking = text "N/A", 650, layout_y
      text "Parking Success Percentage", 250, layout_y(true)
      parking_success_percentage = text "N/A", 650, layout_y
      layout_y

      text "Capball on Floor", 250, layout_y(true)
      capball_on_floor = text "N/A", 650, layout_y
      text "Capball Missed", 250, layout_y(true)
      capball_missed = text "N/A", 650, layout_y
      text "Capball Success Percentage", 250, layout_y(true)
      capball_success_percentage = text "N/A", 650, layout_y
      layout_y

      text "Dead Robot", 250, layout_y(true)
      dead_robot = text "N/A", 650, layout_y
      _x = 10
      _y = 50
      tally_match = MatchLoader::Match.new
      @matches.each_with_index do |match, index|
        p match.autonomous.beacons_claimed
        tally_match.beacons_claimed+=match.autonomous.beacons_claimed
        tally_match.beacons_missed+=match.autonomous.beacons_missed

        tally_match.scored_in_vortex+=match.autonomous.scored_in_vortex
        tally_match.scored_in_corner+=match.autonomous.scored_in_corner
        tally_match.missed_vortex+=match.autonomous.missed_vortex
        tally_match.missed_corner+=match.autonomous.missed_corner

        tally_match.capball_on_floor+=match.autonomous.capball_on_floor
        tally_match.capball_missed+=match.autonomous.capball_missed

        tally_match.completely_on_platform+=match.autonomous.completely_on_platform
        tally_match.completely_on_ramp+=match.autonomous.completely_on_ramp
        tally_match.on_platform+=match.autonomous.on_platform
        tally_match.on_ramp+=match.autonomous.on_ramp

        tally_match.dead_robot+=match.autonomous.dead_robot

        b = button "Match #{index+1}", _x, _y do
          beacons_claimed.text = match.autonomous.beacons_claimed.to_s
          beacons_missed.text = match.autonomous.beacons_missed.to_s
          beacons_success_percentage.text = calc_percentage(match.autonomous.beacons_claimed, match.autonomous.beacons_claimed+match.autonomous.beacons_missed)

          scored_in_vortex.text = match.autonomous.scored_in_vortex.to_s
          scored_in_corner.text = match.autonomous.scored_in_corner.to_s
          missed_vortex.text = match.autonomous.missed_vortex.to_s
          missed_corner.text = match.autonomous.missed_corner.to_s
          scored_in_vortex_success_percentage.text = calc_percentage(match.autonomous.scored_in_vortex, match.autonomous.scored_in_vortex+match.autonomous.missed_vortex)
          scored_in_corner_success_percentage.text = calc_percentage(match.autonomous.scored_in_corner, match.autonomous.scored_in_corner+match.autonomous.missed_corner)

          parked_completely_on_platform.text = match.autonomous.completely_on_platform.to_s
          parked_completely_on_ramp.text = match.autonomous.completely_on_ramp.to_s
          parked_on_platform.text = match.autonomous.on_platform.to_s
          parked_on_ramp.text = match.autonomous.on_ramp.to_s
          missed_parking.text = match.autonomous.missed_parking.to_s
          parking_success_percentage.text = calc_percentage(match.autonomous.completely_on_platform+match.autonomous.completely_on_ramp+match.autonomous.on_platform+match.autonomous.on_ramp, match.autonomous.completely_on_platform+match.autonomous.completely_on_ramp+match.autonomous.on_platform+match.autonomous.on_ramp+match.autonomous.missed_parking)

          capball_on_floor.text = match.autonomous.capball_on_floor.to_s
          capball_missed.text = match.autonomous.capball_missed.to_s
          capball_success_percentage.text = calc_percentage(match.autonomous.capball_on_floor, match.autonomous.capball_on_floor+match.autonomous.capball_missed)

          if match.autonomous.is_dead_robot
            dead_robot.text = "Yes"
            dead_robot.color= BAD_COLOR
          else
            dead_robot.text = "No"
            dead_robot.color= GOOD_COLOR
          end
        end

        _x+=b.width+10
        if (index+1).to_f/2 % 1 == 0
          _x = 10
          _y+=50
        end
      end

      all_matches = button "All Matches", 200, 50 do
        beacons_claimed.text = tally_match.beacons_claimed.to_s
        beacons_missed.text = tally_match.beacons_missed.to_s
        beacons_success_percentage.text = calc_percentage(tally_match.beacons_claimed, tally_match.beacons_claimed+tally_match.beacons_missed)

        scored_in_vortex.text = tally_match.scored_in_vortex.to_s
        scored_in_corner.text = tally_match.scored_in_corner.to_s
        missed_vortex.text = tally_match.missed_vortex.to_s
        missed_corner.text = tally_match.missed_corner.to_s
        scored_in_vortex_success_percentage.text = calc_percentage(tally_match.scored_in_vortex, tally_match.scored_in_vortex+tally_match.missed_vortex)
        scored_in_corner_success_percentage.text = calc_percentage(tally_match.scored_in_corner, tally_match.scored_in_corner+tally_match.missed_corner)

        parked_completely_on_platform.text = tally_match.completely_on_platform.to_s
        parked_completely_on_ramp.text = tally_match.completely_on_ramp.to_s
        parked_on_platform.text = tally_match.on_platform.to_s
        parked_on_ramp.text = tally_match.on_ramp.to_s
        missed_parking.text = tally_match.missed_parking.to_s
        parking_success_percentage.text = calc_percentage(tally_match.completely_on_platform+tally_match.completely_on_ramp+tally_match.on_platform+tally_match.on_ramp, tally_match.completely_on_platform+tally_match.completely_on_ramp+tally_match.on_platform+tally_match.on_ramp+tally_match.missed_parking)


        capball_on_floor.text = tally_match.capball_on_floor.to_s
        capball_missed.text = tally_match.capball_missed.to_s
        capball_success_percentage.text = calc_percentage(tally_match.capball_on_floor, tally_match.capball_on_floor+tally_match.capball_missed)

        dead_robot.text = tally_match.dead_robot.to_s
        dead_robot.color=self.text_color
      end

      all_matches.block.call
    else
      if AppSync.team_name != ""
        text "No match data for #{AppSync.team_name}", 50, 50, 32
      else
        text "No team selected.", 350, 50, 32
      end
    end
  end

  def button_up(id)
    super
    switch_team(id, self.class, :match)
  end
end
