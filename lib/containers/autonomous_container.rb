class AutonomousContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK
    @matches = []

    text "Autonomous", 0, 10, 32, AUTONOMOUS_HEADER_COLOR, :center
    @matches = AppSync.team_match_data

    if AppSync.team_has_match_data?
      set_layout_y(100, 22)

      text "Jewel Scored", 250, layout_y(true)
      jewel_scored = text "N/A", 650, layout_y
      text "Jewel Missed", 250, layout_y(true)
      jewel_missed = text "N/A", 650, layout_y
      text "Jewel Success Percentage", 250, layout_y(true)
      jewel_success_percentage = text "N/A", 650, layout_y
      layout_y

      text "Glyph Scored", 250, layout_y(true)
      glyph_scored = text "N/A", 650, layout_y
      text "Glyph Missed", 250, layout_y(true)
      glyph_missed = text "N/A", 650, layout_y
      text "Glyph Read Cryptobox Key", 250, layout_y(true)
      glyph_read_cryptobox_key = text "N/A", 650, layout_y
      text "Glyph Success Percentage", 250, layout_y(true)
      glyph_success_percentage = text "N/A", 650, layout_y
      layout_y

      text "Parked in Safe Zone", 250, layout_y(true)
      parked_in_safe_zone = text "N/A", 650, layout_y
      text "Missed Parking in Safe Zone", 250, layout_y(true)
      parking_missed = text "N/A", 650, layout_y
      text "Parking Success Percentage", 250, layout_y(true)
      parking_success_percentage = text "N/A", 650, layout_y
      layout_y

      text "Dead Robot", 250, layout_y(true)
      dead_robot = text "N/A", 650, layout_y
      _x = 10
      _y = 50
      tally_match = MatchLoader::Match.new
      @matches.each_with_index do |match, index|
        tally_match.jewel_scored+=match.autonomous.jewel_scored
        tally_match.jewel_missed+=match.autonomous.jewel_missed

        tally_match.glyph_scored+=match.autonomous.glyph_scored
        tally_match.glyph_missed+=match.autonomous.glyph_missed
        tally_match.glyph_read_cryptobox_key+=match.autonomous.glyph_read_cryptobox_key

        tally_match.parked_in_safe_zone+=match.autonomous.parked_in_safe_zone
        tally_match.parking_missed+=match.autonomous.parking_missed

        tally_match.dead_robot+=match.autonomous.dead_robot

        b = button "Match #{index+1}", _x, _y do
          jewel_scored.text = match.autonomous.jewel_scored.to_s
          jewel_missed.text = match.autonomous.jewel_missed.to_s
          jewel_success_percentage.text = calc_percentage(match.autonomous.jewel_scored, match.autonomous.jewel_scored+match.autonomous.jewel_missed)

          glyph_scored.text = match.autonomous.glyph_scored.to_s
          glyph_missed.text = match.autonomous.glyph_missed.to_s
          glyph_read_cryptobox_key.text = match.autonomous.glyph_read_cryptobox_key.to_s
          glyph_success_percentage.text = calc_percentage(match.autonomous.glyph_scored, match.autonomous.glyph_scored+match.autonomous.glyph_missed)

          parked_in_safe_zone.text = match.autonomous.parked_in_safe_zone.to_s
          parking_missed.text = match.autonomous.parking_missed.to_s
          parking_success_percentage.text = calc_percentage(match.autonomous.parked_in_safe_zone, match.autonomous.parked_in_safe_zone+match.autonomous.parking_missed)

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
        jewel_scored.text = tally_match.jewel_scored.to_s
        jewel_missed.text = tally_match.jewel_missed.to_s
        jewel_success_percentage.text = calc_percentage(tally_match.jewel_scored, tally_match.jewel_scored+tally_match.jewel_missed)

        glyph_scored.text = tally_match.jewel_scored.to_s
        glyph_missed.text = tally_match.jewel_missed.to_s
        glyph_read_cryptobox_key.text = tally_match.glyph_read_cryptobox_key.to_s
        glyph_success_percentage.text = calc_percentage(tally_match.glyph_scored, tally_match.glyph_scored+tally_match.glyph_missed)

        parked_in_safe_zone.text = tally_match.parked_in_safe_zone.to_s
        parking_missed.text = tally_match.parking_missed.to_s
        parking_success_percentage.text = calc_percentage(tally_match.parked_in_safe_zone, tally_match.parked_in_safe_zone+tally_match.parking_missed)

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
