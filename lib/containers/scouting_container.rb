class ScoutingContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    text "Autonomous", 400, 10, 32, AUTONOMOUS_HEADER_COLOR
    a_y = 45
    text "Can Claim Beacons", 250, a_y
    auto_can_claim_beacons = text "N/A", 650, a_y
    text "Max Beacons Claimable", 250, a_y+22
    auto_max_beacons_claimable = text "N/A", 650, a_y+22
    text "Can Score in corner", 250, a_y+44
    auto_can_score_in_vortex = text "N/A", 650, a_y+44
    text "Max Particles Scored in Vortex", 250, a_y+66
    auto_particles_scored_in_vortex = text "N/A", 650, a_y+66
    text "Can Score in Corner", 250, a_y+88
    auto_can_score_in_corner = text "N/A", 650, a_y+88
    text "Max Particles Scored in Corner", 250, a_y+110
    auto_particles_scored_in_corner = text "N/A", 650, a_y+110
    text "Can put Capball on Floor", 250, a_y+132
    auto_capball_on_floor = text "N/A", 650, a_y+132
    text "Can Park Completely on Platform", 250, a_y+154
    auto_park_completely_on_platform = text "N/A", 650, a_y+154
    text "Can Park Completely on Ramp", 250, a_y+176
    auto_park_completely_on_ramp = text "N/A", 650, a_y+176
    text "Can Park on Platform", 250, a_y+198
    auto_park_on_platform = text "N/A", 650, a_y+198
    text "Can Park on Ramp", 250, a_y+220
    auto_park_on_ramp = text "N/A", 650, a_y+220

    text "TeleOp", 430, 300, 32, TELEOP_HEADER_COLOR
    a_y = 340
    text "Can Claim Beacons", 250, a_y
    tele_can_claim_beacons = text "N/A", 650, a_y
    text "Max Beacons Claimable", 250, a_y+22
    tele_max_beacons_claimable = text "N/A", 650, a_y+22
    text "Can Score in Vortex", 250, a_y+44
    tele_can_score_in_vortex = text "N/A", 650, a_y+44
    text "Max Particles Scored in Vortex", 250, a_y+66
    tele_particles_scored_in_vortex = text "N/A", 650, a_y+66
    text "Can Score in Corner", 250, a_y+88
    tele_can_score_in_corner = text "N/A", 650, a_y+88
    text "Max Particles Scored in Corner", 250, a_y+110
    tele_particles_scored_in_corner = text "N/A", 650, a_y+110
    text "Capball off Floor", 250, a_y+132
    tele_capball_off_floor = text "N/A", 650, a_y+132
    text "Capball Above Crossbar", 250, a_y+154
    tele_capball_above_crossbar = text "N/A", 650, a_y+154
    text "Capball Capped", 250, a_y+176
    tele_capball_capped = text "N/A", 650, a_y+176

    if AppSync.team_has_scouting_data?
      autonomous = AppSync.team_scouting_data("autonomous")
      teleop     = AppSync.team_scouting_data("teleop")

      # AUTONOMOUS
      if autonomous["has_autonomous"]
        if autonomous["can_claim_beacons"]
          auto_can_claim_beacons.text = "Yes"
          auto_can_claim_beacons.color = GOOD_COLOR
          auto_max_beacons_claimable.color = GOOD_COLOR
        else
          auto_can_claim_beacons.text = "No"
          auto_can_claim_beacons.color = BAD_COLOR
        end
        auto_max_beacons_claimable.text = autonomous["max_beacons_claimable"].to_s

        if autonomous["can_score_in_vortex"]
          auto_can_score_in_vortex.text = "Yes"
          auto_can_score_in_vortex.color= GOOD_COLOR
          auto_particles_scored_in_vortex.color = GOOD_COLOR
        else
          auto_can_score_in_vortex.text = "No"
          auto_can_score_in_vortex.color= BAD_COLOR
        end
        auto_particles_scored_in_vortex.text = autonomous["max_particles_scored_in_vortex"].to_s

        if autonomous["can_score_in_corner"]
          auto_can_score_in_corner.text = "Yes"
          auto_can_score_in_corner.color= GOOD_COLOR
          auto_particles_scored_in_corner.color = GOOD_COLOR
        else
          auto_can_score_in_corner.text = "No"
          auto_can_score_in_corner.color= BAD_COLOR
        end
        auto_particles_scored_in_corner.text = autonomous["max_particles_scored_in_corner"].to_s

        if autonomous["capball_on_floor"]
          auto_capball_on_floor.text = "Yes"
          auto_capball_on_floor.color= GOOD_COLOR
        else
          auto_capball_on_floor.text = "No"
          auto_capball_on_floor.color= BAD_COLOR
        end

        if autonomous["park_completely_on_platform"]
          auto_park_completely_on_platform.text = "Yes"
          auto_park_completely_on_platform.color= GOOD_COLOR
        else
          auto_park_completely_on_platform.text = "No"
          auto_park_completely_on_platform.color= BAD_COLOR
        end

        if autonomous["park_completely_on_ramp"]
          auto_park_completely_on_ramp.text = "Yes"
          auto_park_completely_on_ramp.color= GOOD_COLOR
        else
          auto_park_completely_on_ramp.text = "No"
          auto_park_completely_on_ramp.color= BAD_COLOR
        end

        if autonomous["park_on_platform"]
          auto_park_on_platform.text = "Yes"
          auto_park_on_platform.color= GOOD_COLOR
        else
          auto_park_on_platform.text = "No"
          auto_park_on_platform.color= BAD_COLOR
        end

        if autonomous["park_on_ramp"]
          auto_park_on_ramp.text = "Yes"
          auto_park_on_ramp.color= GOOD_COLOR
        else
          auto_park_on_ramp.text = "No"
          auto_park_on_ramp.color= BAD_COLOR
        end
      end

      # TELEOP
      if teleop.count > 1
        if teleop["can_claim_beacons"]
          tele_can_claim_beacons.text = "Yes"
          tele_can_claim_beacons.color = GOOD_COLOR
          tele_max_beacons_claimable.color = GOOD_COLOR
        else
          tele_can_claim_beacons.text = "No"
          tele_can_claim_beacons.color = BAD_COLOR
        end
        tele_max_beacons_claimable.text = teleop["max_beacons_claimable"].to_s

        if teleop["can_score_in_vortex"]
          tele_can_score_in_vortex.text = "Yes"
          tele_can_score_in_vortex.color = GOOD_COLOR
          tele_particles_scored_in_vortex.color = GOOD_COLOR
        else
          tele_can_score_in_vortex.text = "No"
          tele_can_score_in_vortex.color = BAD_COLOR
        end
        tele_particles_scored_in_vortex.text = teleop["max_particles_scored_in_vortex"].to_s

        if teleop["can_score_in_corner"]
          tele_can_score_in_corner.text = "Yes"
          tele_can_score_in_corner.color = GOOD_COLOR
          tele_particles_scored_in_corner.color = GOOD_COLOR
        else
          tele_can_score_in_corner.text = "No"
          tele_can_score_in_corner.color = BAD_COLOR
        end
        tele_particles_scored_in_corner.text = teleop["max_particles_scored_in_corner"].to_s

        if teleop["capball_off_floor"]
          tele_capball_off_floor.text = "Yes"
          tele_capball_off_floor.color = GOOD_COLOR
        else
          tele_capball_off_floor.text = "No"
          tele_capball_off_floor.color = BAD_COLOR
        end

        if teleop["capball_above_crossbar"]
          tele_capball_above_crossbar.text = "Yes"
          tele_capball_above_crossbar.color = GOOD_COLOR
        else
          tele_capball_above_crossbar.text = "No"
          tele_capball_above_crossbar.color = BAD_COLOR
        end

        if teleop["capball_capped"]
          tele_capball_capped.text = "Yes"
          tele_capball_capped.color = GOOD_COLOR
        else
          tele_capball_capped.text = "No"
          tele_capball_capped.color = BAD_COLOR
        end
      end
    end
  end

  def button_up(id)
    super
    case id
    when Gosu::KbRight
      current_team = AppSync.team_number
      AppSync.teams_list.detect do |number, name|
        if number > current_team
          AppSync.active_team(number)
          $window.active_container = ScoutingContainer.new
          true
        end
      end

      if AppSync.team_number == current_team
        AppSync.active_team(AppSync.teams_list.first.first)
        $window.active_container = ScoutingContainer.new
      end

    when Gosu::KbLeft
      current_team = AppSync.team_number
      teams = []
      AppSync.teams_list.each do |number, name|
        if number < current_team
          teams.push(number)
        end
      end

      if teams.last
        AppSync.active_team(teams.last)
        $window.active_container = ScoutingContainer.new
      end

      if AppSync.team_number == current_team
        AppSync.active_team(AppSync.teams_list.to_a.last.first)
        $window.active_container = ScoutingContainer.new
      end
    end
  end
end
