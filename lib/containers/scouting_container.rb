class ScoutingContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    if AppSync.team_has_scouting_data?
      autonomous = AppSync.team_scouting_data("autonomous")
      teleop     = AppSync.team_scouting_data("teleop")
    end

    if AppSync.team_has_scouting_data? && (autonomous.count > 2 || teleop.count > 0)
      text "Autonomous", 0, 10, 32, AUTONOMOUS_HEADER_COLOR, :center
      set_layout_y(50, 22)
      text "Can Score Jewel", 250, layout_y(true)
      auto_can_score_jewel = text "N/A", 650, layout_y
      text "Can Score Cryptobox", 250, layout_y(true)
      auto_can_score_in_cryptobox = text "N/A", 650, layout_y
      text "Can Read Cryptobox key", 250, layout_y(true)
      auto_can_read_cryptobox_key = text "N/A", 650, layout_y
      text "Max Glyphs Scorable", 250, layout_y(true)
      auto_max_glyphs_scorable = text "N/A", 650, layout_y
      text "Can Park in Safe Zone", 250, layout_y(true)
      auto_can_park_in_safe_zone = text "N/A", 650, layout_y

      text "TeleOp", 0, 300, 32, TELEOP_HEADER_COLOR, :center
      set_layout_y(340, 22)
      text "Can Score in Cryptobox", 250, layout_y(true)
      tele_can_score_in_cryptobox = text "N/A", 650, layout_y
      text "Max Glyphs Scorable", 250, layout_y(true)
      tele_max_glyphs_scorable = text "N/A", 650, layout_y
      text "Can Complete Cipher", 250, layout_y(true)
      tele_can_complete_cipher = text "N/A", 650, layout_y
      text "Can Score Relic", 250, layout_y(true)
      tele_can_score_relic = text "N/A", 650, layout_y
      text "Relic Zone(s)", 250, layout_y(true)
      tele_relic_zone = text "N/A", 650, layout_y
      text "Can Place Relic Upright", 250, layout_y(true)
      tele_can_place_relic_upright = text "N/A", 650, layout_y
      text "Can Balance on Stone", 250, layout_y(true)
      tele_can_balance_on_stone = text "N/A", 650, layout_y
    else
      if !AppSync.team_has_scouting_data?
        text "Scouting", 0, 10, 32, Gosu::Color::BLACK, :center
        text "No team selected.", 0, 50, 32, Gosu::Color::BLACK, :center
      else
        text "No Scouting Data", 0, 10, 32, Gosu::Color::BLACK, :center
      end
      if AppSync.team_has_scouting_data? && autonomous.count < 5
        text "Team has no Autonomous, and TeleOp data was not stored/collected.", 10, 40, 32
      end
    end

    if AppSync.team_has_scouting_data?

      # AUTONOMOUS
      if autonomous["has_autonomous"]
        if autonomous["can_score_jewel"]
          auto_can_score_jewel.text = "Yes"
          auto_can_score_jewel.color = GOOD_COLOR
        else
          auto_can_score_jewel.text = "No"
          auto_can_score_jewel.color = BAD_COLOR
        end

        if autonomous["can_score_in_cryptobox"]
          auto_can_score_in_cryptobox.text = "Yes"
          auto_can_score_in_cryptobox.color= GOOD_COLOR
          auto_max_glyphs_scorable.color   = GOOD_COLOR
        else
          auto_can_score_in_cryptobox.text = "No"
          auto_can_score_in_cryptobox.color= BAD_COLOR
          auto_max_glyphs_scorable.color   = BAD_COLOR
        end
        auto_max_glyphs_scorable.text    = autonomous["max_glyphs_scorable"].to_s

        if autonomous["can_read_cryptobox_key"]
          auto_can_read_cryptobox_key.text = "Yes"
          auto_can_read_cryptobox_key.color= GOOD_COLOR
        else
          auto_can_read_cryptobox_key.text = "No"
          auto_can_read_cryptobox_key.color= BAD_COLOR
        end

        if autonomous["can_park_in_safe_zone"]
          auto_can_park_in_safe_zone.text = "Yes"
          auto_can_park_in_safe_zone.color= GOOD_COLOR
        else
          auto_can_park_in_safe_zone.text = "No"
          auto_can_park_in_safe_zone.color= BAD_COLOR
        end
      end

      # TELEOP
      if teleop.count > 1
        if teleop["can_score_in_cryptobox"]
          tele_can_score_in_cryptobox.text = "Yes"
          tele_can_score_in_cryptobox.color= GOOD_COLOR
          tele_max_glyphs_scorable.color   = GOOD_COLOR
        else
          tele_can_score_in_cryptobox.text = "No"
          tele_can_score_in_cryptobox.color= BAD_COLOR
        end
        tele_max_glyphs_scorable.text = teleop["max_scorable_glyphs"].to_s

        if teleop["can_complete_cipher"]
          tele_can_complete_cipher.text  = "Yes"
          tele_can_complete_cipher.color = GOOD_COLOR
        else
          tele_can_complete_cipher.text  = "No"
          tele_can_complete_cipher.color = BAD_COLOR
        end

        if teleop["can_score_relic"]
          tele_can_score_relic.text = "Yes"
          tele_can_score_relic.color = GOOD_COLOR
          tele_relic_zone.color      = GOOD_COLOR
          _list = []
          if teleop["relic_zone_1"]; _list << "ONE"; end
          if teleop["relic_zone_2"]; _list << "TWO"; end
          if teleop["relic_zone_3"]; _list << "THREE"; end
          tele_relic_zone.text = _list.join(", ")
          tele_relic_zone.text = "N/A" if tele_relic_zone.text == ""
        else
          tele_can_score_relic.text = "No"
          tele_can_score_relic.color = BAD_COLOR
        end

        if teleop["relic_upright"]
          tele_can_place_relic_upright.text = "Yes"
          tele_can_place_relic_upright.color = GOOD_COLOR
        else
          tele_can_place_relic_upright.text = "No"
          tele_can_place_relic_upright.color = BAD_COLOR
        end

        if teleop["can_balance_on_stone"]
          tele_can_balance_on_stone.text = "Yes"
          tele_can_balance_on_stone.color = GOOD_COLOR
        else
          tele_can_balance_on_stone.text = "No"
          tele_can_balance_on_stone.color = BAD_COLOR
        end
      end
    end
  end

  def button_up(id)
    super
    switch_team(id, self.class, :scouting)
  end
end
