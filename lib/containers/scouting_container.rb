class ScoutingContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    if AppSync.team_has_scouting_data?
      AppSync.team_scouting_data("autonomous")
      AppSync.team_scouting_data("teleop")
    end

    text "Autonomous", 400, 10, 32, AUTONOMOUS_HEADER_COLOR
    a_y = 45
    text "Can Claim Beacons", 250, a_y
    auto_can_claim_beacons = text "N/A", 650, a_y
    text "Max Beacons Claimable", 250, a_y+22
    auto_max_beacons_claimable = text "N/A", 650, a_y+22
    text "Can Score in Vortex", 250, a_y+44
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
  end

  def draw
    # fill(Gosu::Color.rgb(35, 16, 29))
    super
  end
end
