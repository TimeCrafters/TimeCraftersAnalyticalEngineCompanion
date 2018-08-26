class ScoutingContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    if AppSync.team_has_scouting_data?
      autonomous = AppSync.team_scouting_data("autonomous")
      teleop     = AppSync.team_scouting_data("teleop")
    end

    if AppSync.team_has_scouting_data? && (autonomous.count > 2 || teleop.count > 0)
      populate_fields(AppSync.schema.scouting_autonomous, :autonomous)
      populate_fields(AppSync.schema.scouting_teleop, :teleop)

    else
      text "Scouting", 0, 10, 32, SCOUTING_HEADER_COLOR, :center
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
    end
  end

  def populate_fields(array, period)
    scouting_data = {}
    if period == :autonomous
      text "Autonomous", 0, 10, 32, AUTONOMOUS_HEADER_COLOR, :center
      scouting_data = AppSync.team_scouting_data(:autonomous)
      set_layout_y(50, 22)

    elsif period == :teleop
      text "TeleOp", 0, relative_y(@elements.last.y)+@elements.last.height+32, 32, TELEOP_HEADER_COLOR, :center
      scouting_data = AppSync.team_scouting_data(:teleop)
      set_layout_y(relative_y(@elements.last.y)+@elements.last.height, 22)

    else raise
    end

    main_x = ($window.width/4)*1#250
    data_x = ($window.width/4)*2.7#650

    array.each do |data|
      text friendlify(data["name"]), main_x, layout_y(true), 22
      case data["type"]
      when "boolean"
        s = scouting_data[data["name"]] ? "Yes" : "No"
        c = scouting_data[data["name"]] ? GOOD_COLOR : BAD_COLOR
        text s, data_x, layout_y, 22, c
      when "number"
        c = (scouting_data[data["name"]] > 0) ? GOOD_COLOR : BAD_COLOR
        text scouting_data[data["name"]], data_x, layout_y, 22, c
      when "string"
        s = (scouting_data[data["name"]].strip.length == 0) ? "\"\"" : scouting_data[data["name"]]
        text s, data_x, layout_y, 22
      end
    end
  end

  def button_up(id)
    super
    switch_team(id, self.class, :scouting)
  end
end
