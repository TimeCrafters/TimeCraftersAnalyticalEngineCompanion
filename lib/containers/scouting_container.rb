class ScoutingContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    if AppSync.team_has_scouting_data?
      autonomous = AppSync.team_scouting_data("autonomous")
      teleop     = AppSync.team_scouting_data("teleop")
    end

    if AppSync.team_has_scouting_data? && (autonomous.count > 2 || teleop.count > 0)
      text "Autonomous", 0, 10, 32, AUTONOMOUS_HEADER_COLOR, :center
      main_x = ($window.width/4)*1#250
      data_x = ($window.width/4)*2.7#650

      set_layout_y(50, 22)
      text "Can Score Jewel", main_x, layout_y(true)
      auto_can_score_jewel = text "N/A", data_x, layout_y
      text "Can Score in Cryptobox", main_x, layout_y(true)
      auto_can_score_in_cryptobox = text "N/A", data_x, layout_y
      text "Can Read Cryptobox Key", main_x, layout_y(true)
      auto_can_read_cryptobox_key = text "N/A", data_x, layout_y
      text "Max Glyphs Scorable", main_x, layout_y(true)
      auto_max_glyphs_scorable = text "N/A", data_x, layout_y
      text "Can Park in Safe Zone", main_x, layout_y(true)
      auto_can_park_in_safe_zone = text "N/A", data_x, layout_y

      text "TeleOp", 0, 200, 32, TELEOP_HEADER_COLOR, :center
      set_layout_y(240, 22)
      text "Can Score in Cryptobox", main_x, layout_y(true)
      tele_can_score_in_cryptobox = text "N/A", data_x, layout_y
      text "Max Glyphs Scorable", main_x, layout_y(true)
      tele_max_glyphs_scorable = text "N/A", data_x, layout_y
      text "Can Complete Cipher", main_x, layout_y(true)
      tele_can_complete_cipher = text "N/A", data_x, layout_y
      text "Can Score Relic", main_x, layout_y(true)
      tele_can_score_relic = text "N/A", data_x, layout_y
      text "Relic Zone(s)", main_x, layout_y(true)
      tele_relic_zone = text "N/A", data_x, layout_y
      text "Can Place Relic Upright", main_x, layout_y(true)
      tele_can_place_relic_upright = text "N/A", data_x, layout_y
      text "Can Balance on Stone", main_x, layout_y(true)
      tele_can_balance_on_stone = text "N/A", data_x, layout_y
    else
      text "Scouting", 0, 10, 32, Gosu::Color::BLACK, :center
      if AppSync.team_name == ""
        text "No team selected.", 0, 50, 32, Gosu::Color::BLACK, :center
      elsif !AppSync.team_has_scouting_data? && AppSync.team_name != ""
        text "No Scouting Data", 0, 50, 32, Gosu::Color::BLACK, :center
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
        tele_max_glyphs_scorable.text = teleop["max_scorable_glyphs"] unless teleop["max_scorable_glyphs"] == nil
        tele_max_glyphs_scorable.text = teleop["max_glyphs_scorable"] if teleop["max_scorable_glyphs"] == nil

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
