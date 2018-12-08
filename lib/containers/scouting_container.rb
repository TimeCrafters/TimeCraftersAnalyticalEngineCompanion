class ScoutingContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

      text "Scouting", 0, 10, Text::SIZE_HEADER, SCOUTING_HEADER_COLOR, :center
    if AppSync.team_has_scouting_data?
      autonomous = AppSync.team_scouting_data("autonomous")
      teleop     = AppSync.team_scouting_data("teleop")
    end

    if AppSync.team_has_scouting_data? && (autonomous.count > 2 || teleop.count > 0)
      populate_fields(AppSync.schema.scouting_autonomous, :autonomous)
      populate_fields(AppSync.schema.scouting_teleop, :teleop)

    else
      if AppSync.team_name == ""
        text "No team selected.", 0, Text::SIZE_HEADER, Text::SIZE_HEADING, Gosu::Color::BLACK, :center
      elsif !AppSync.team_has_scouting_data? && AppSync.team_name != ""
        text "No Scouting Data", 0, Text::SIZE_HEADER, Text::SIZE_HEADING, Gosu::Color::BLACK, :center
      end
      if AppSync.team_has_scouting_data? && autonomous.count < 5
        text "Team has no Autonomous, and TeleOp data was not stored/collected.", 10, 40, Text::SIZE_HEADING
      end
    end

    if AppSync.team_has_scouting_data?
    end
  end

  def populate_fields(array, period)
    scouting_data = {}
    if period == :autonomous
      text "Autonomous", 0, relative_y(@elements.last.y)+@elements.last.height, Text::SIZE_HEADING, AUTONOMOUS_HEADER_COLOR, :center
      scouting_data = AppSync.team_scouting_data(:autonomous)
      set_layout_y(relative_y(@elements.last.y)+@elements.last.height, Text::SIZE)

    elsif period == :teleop
      text "TeleOp", 0, relative_y(@elements.last.y)+@elements.last.height+Text::SIZE_HEADING, Text::SIZE_HEADING, TELEOP_HEADER_COLOR, :center
      scouting_data = AppSync.team_scouting_data(:teleop)
      set_layout_y(relative_y(@elements.last.y)+@elements.last.height, Text::SIZE)

    else raise
    end

    main_x = ($window.width/4)*1#250
    data_x = ($window.width/4)*2.7#650

    array.each do |data|
      text friendlify(data["name"]), main_x, layout_y(true), Text::SIZE
      case data["type"]
      when "boolean"
        s = scouting_data[data["name"]] ? "Yes" : "No"
        c = scouting_data[data["name"]] ? GOOD_COLOR : BAD_COLOR
        text s, data_x, layout_y, Text::SIZE, c
      when "number"
        pp scouting_data, data["name"]
        c = (scouting_data[data["name"]].to_i > 0) ? GOOD_COLOR : BAD_COLOR
        text scouting_data[data["name"]], data_x, layout_y, Text::SIZE, c
      when "string"
        s = (scouting_data[data["name"]].strip.length == 0) ? "\"\"" : scouting_data[data["name"]]
        text s, data_x, layout_y, Text::SIZE
      end
    end
  end

  def button_up(id)
    super
    switch_team(id, self.class, :scouting)
  end
end
