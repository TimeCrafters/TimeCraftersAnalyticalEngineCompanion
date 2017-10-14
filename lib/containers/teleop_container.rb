class TeleOpContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK
    @matches = []

    text "TeleOp", 0, 10, 32, TELEOP_HEADER_COLOR, :center

    if AppSync.team_has_match_data?
      set_layout_y(100, 22)

      text "Glyph Scored", 250, layout_y(true)
      glyph_scored = text "N/A", 650, layout_y
      text "Glyph Missed", 250, layout_y(true)
      glyph_missed = text "N/A", 650, layout_y
      text "glyph Success Percentage", 250, layout_y(true)
      glyph_success_percentage = text "N/A", 650, layout_y
      layout_y

      text "Relic Zone 1", 250, layout_y(true)
      relic_zone_1 = text "N/A", 650, layout_y
      text "Relic Zone 2", 250, layout_y(true)
      relic_zone_2 = text "N/A", 650, layout_y
      text "Relic Zone 3", 250, layout_y(true)
      relic_zone_3 = text "N/A", 650, layout_y
      text "Relic Upright", 250, layout_y(true)
      relic_upright = text "N/A", 650, layout_y
      text "Relic Missed", 250, layout_y(true)
      relic_missed = text "N/A", 650, layout_y
      text "Relic Success Percentage", 250, layout_y(true)
      relic_success_percentage = text "N/A", 650, layout_y
      layout_y

      text "Balanced on Stone", 250, layout_y(true)
      balanced_on_stone = text "N/A", 650, layout_y
      text "Missed Balancing on Stone", 250, layout_y(true)
      balancing_missed = text "N/A", 650, layout_y
      text "Parking Success Percentage", 250, layout_y(true)
      parking_success_percentage = text "N/A", 650, layout_y
      layout_y

      text "Dead Robot", 250, layout_y(true)
      dead_robot = text "N/A", 650, layout_y

      @matches = AppSync.team_match_data

      _x = 10
      _y = 50
      tally_match = MatchLoader::Match.new

      @matches.each_with_index do |match, index|
        tally_match.glyph_scored+=match.teleop.glyph_scored
        tally_match.glyph_missed+=match.teleop.glyph_missed

        tally_match.relic_zone_1+=match.teleop.relic_zone_1
        tally_match.relic_zone_2+=match.teleop.relic_zone_2
        tally_match.relic_zone_3+=match.teleop.relic_zone_3
        tally_match.relic_upright+=match.teleop.relic_upright
        tally_match.relic_missed+=match.teleop.relic_missed

        tally_match.balanced_on_stone+=match.teleop.balanced_on_stone
        tally_match.balancing_missed+=match.teleop.balancing_missed

        tally_match.dead_robot+=match.teleop.dead_robot

        b = button "Match #{index+1}", _x, _y do
          glyph_scored.text = match.teleop.glyph_scored.to_s
          glyph_missed.text = match.teleop.glyph_missed.to_s
          glyph_success_percentage.text = calc_percentage(match.teleop.glyph_scored, match.teleop.glyph_scored+match.teleop.glyph_missed)

          relic_zone_1.text  = match.teleop.relic_zone_1.to_s
          relic_zone_2.text  = match.teleop.relic_zone_2.to_s
          relic_zone_3.text  = match.teleop.relic_zone_3.to_s
          relic_upright.text = match.teleop.relic_upright.to_s
          relic_missed.text = match.teleop.relic_missed.to_s
          relic_success_percentage.text = calc_percentage(match.teleop.relic_zone_1+match.teleop.relic_zone_2+match.teleop.relic_zone_3, match.teleop.relic_zone_1+match.teleop.relic_zone_2+match.teleop.relic_zone_3+match.teleop.relic_missed)

          balanced_on_stone.text = match.teleop.balanced_on_stone.to_s
          balancing_missed.text = match.teleop.balancing_missed.to_s
          parking_success_percentage.text = calc_percentage(match.teleop.balanced_on_stone, match.teleop.balanced_on_stone+match.teleop.balancing_missed)

          if match.teleop.is_dead_robot
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
        glyph_scored.text = tally_match.glyph_scored.to_s
        glyph_missed.text = tally_match.glyph_missed.to_s
        glyph_success_percentage.text = calc_percentage(tally_match.glyph_scored, tally_match.glyph_scored+tally_match.glyph_missed)

        relic_zone_1.text  = tally_match.relic_zone_1.to_s
        relic_zone_2.text  = tally_match.relic_zone_2.to_s
        relic_zone_3.text  = tally_match.relic_zone_3.to_s
        relic_upright.text = tally_match.relic_upright.to_s
        relic_missed.text = tally_match.relic_missed.to_s
        relic_success_percentage.text = calc_percentage(tally_match.relic_zone_1+tally_match.relic_zone_2+tally_match.relic_zone_3, tally_match.relic_zone_1+tally_match.relic_zone_2+tally_match.relic_zone_3+tally_match.relic_missed)

        balanced_on_stone.text = tally_match.balanced_on_stone.to_s
        balancing_missed.text = tally_match.balancing_missed.to_s
        parking_success_percentage.text = calc_percentage(tally_match.balanced_on_stone, tally_match.balanced_on_stone+tally_match.balancing_missed)

        dead_robot.text = tally_match.dead_robot.to_s
        dead_robot.color=self.text_color
      end

      all_matches.block.call
    else
      if AppSync.team_name != ""
        text "No match data for #{AppSync.team_name}", 0, 50, 32, Gosu::Color::BLACK, :center
      else
        text "No team selected.", 0, 50, 32, Gosu::Color::BLACK, :center
      end
    end
  end

  def button_up(id)
    super
    switch_team(id, self.class, :match)
  end
end
