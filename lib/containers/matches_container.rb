class MatchesContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK
    @matches = []

    text "Matches", 0, 10, Text::SIZE_HEADER, MATCHES_HEADER_COLOR, :center
    @matches = AppSync.team_match_data

    if AppSync.team_has_match_data?
      main_x = ($window.width/4)*1#250
      data_x = ($window.width/4)*2.7#650

      text "Autonomous", 0, relative_y(@elements.last.y)+@elements.last.height, Text::SIZE_HEADING, AUTONOMOUS_HEADER_COLOR, :center
      set_layout_y(100, Text::SIZE)

      tally_match = MatchLoader::Match.new
      @autonomous_fields = populate_fields(MatchLoader::Match.new.autonomous)

      t = text "TeleOp", 0, layout_y, Text::SIZE_HEADING, TELEOP_HEADER_COLOR, :center
      set_layout_y(relative_y(t.y)+Text::SIZE_HEADING, Text::SIZE)
      @teleop_fields = populate_fields(MatchLoader::Match.new.teleop)

      _x = 10
      _y = Text::SIZE_HEADER
      @matches.each_with_index do |match, index|

        b = button "Match #{index+1}", _x, _y do
          single_match(match)
        end

        _x+=b.width+10
        if (index+1).to_f/2 % 1 == 0
          _x = 10
          _y+=50
        end
      end

      all_matches = button "All Matches", 210, Text::SIZE_HEADER do
        tally_all_matches(tally_match)
      end

      all_matches.block.call
    else
      if AppSync.team_name != ""
        text "No match data for #{AppSync.team_name}", 0, Text::SIZE_HEADER, Text::SIZE_HEADING, Gosu::Color::BLACK, :center
      else
        text "No team selected.", 0, Text::SIZE_HEADER, Text::SIZE_HEADING, Gosu::Color::BLACK, :center
      end
    end
  end

  def tally_all_matches(tally_match)
    unless tally_match.frozen?
      @matches.each do |match|
        match.autonomous.each do |key, value|
          next if key == "_data"
          tally_match.autonomous[key]+=value
        end
        match.teleop.each do |key, value|
          next if key == "_data"
          tally_match.teleop[key]+=value
        end
      end
    end
    tally_match.freeze

    colorize_fields(tally_match, :autonomous)
    colorize_fields(tally_match, :teleop)
  end

  def single_match(match, period = nil)
    match.autonomous.each do |key, value|
      next if key == "_data"
      case match.autonomous["_data"][key]["type"]
      when "boolean"
        c = value > 0 ? GOOD_COLOR : BAD_COLOR unless key.start_with?("missed")
        c = value > 0 ? BAD_COLOR : GOOD_COLOR if key.start_with?("missed")
        v = value > 0 ? "Yes" : "No"

        @autonomous_fields[key]["data"].color= c
        @autonomous_fields[key]["data"].text = "#{v}"
      when "number"
        c = value > 0 ? GOOD_COLOR : BAD_COLOR unless key.start_with?("missed")
        c = value > 0 ? BAD_COLOR : GOOD_COLOR if key.start_with?("missed")

        @autonomous_fields[key]["data"].color= c
        @autonomous_fields[key]["data"].text = "#{value}"
      when "string"
        @autonomous_fields[key]["data"].color= text_color
        @autonomous_fields[key]["data"].text = "#{value}"
      end
    end

    match.teleop.each do |key, value|
      next if key == "_data"
      case match.teleop["_data"][key]["type"]
      when "boolean"
        c = value > 0 ? GOOD_COLOR : BAD_COLOR unless key.start_with?("missed")
        c = value > 0 ? BAD_COLOR : GOOD_COLOR if key.start_with?("missed")
        v = value > 0 ? "Yes" : "No"

        @teleop_fields[key]["data"].color= c
        @teleop_fields[key]["data"].text = "#{v}"
      when "number"
        c = value > 0 ? GOOD_COLOR : BAD_COLOR unless key.start_with?("missed")
        c = value > 0 ? BAD_COLOR : GOOD_COLOR if key.start_with?("missed")

        @teleop_fields[key]["data"].color= c
        @teleop_fields[key]["data"].text = "#{value}"
      when "string"
        @teleop_fields[key]["data"].color= text_color
        @teleop_fields[key]["data"].text = "#{value}"
      end
    end
  end

  def colorize_fields(match, period)
    match_data = (period == :autonomous) ? match.autonomous : match.teleop
    fields = (period == :autonomous) ? @autonomous_fields : @teleop_fields

    match_data.each do |key, value|
      next if key == "_data"
      case match_data["_data"][key]["type"]
      when "boolean"
        c = value > 0 ? GOOD_COLOR : BAD_COLOR unless key.start_with?("missed")
        c = value > 0 ? BAD_COLOR : GOOD_COLOR if key.start_with?("missed")

        fields[key]["data"].color= c
        fields[key]["data"].text = "#{value}"
      when "number"
        c = value > 0 ? GOOD_COLOR : BAD_COLOR unless key.start_with?("missed")
        c = value > 0 ? BAD_COLOR : GOOD_COLOR if key.start_with?("missed")

        fields[key]["data"].color= c
        fields[key]["data"].text = "#{value}"
      when "string"
        fields[key]["data"].color= text_color
        fields[key]["data"].text = "#{value}"
      end
    end
  end

  def populate_fields(hash)
    main_x = ($window.width/4)*1#250
    data_x = ($window.width/4)*2.7#650
    _fields = {}

    hash.each do |key, value|
      next if key == "_data"

      _fields[key] = {}
      name = hash.dig("_data", key, "friendly_name") ? friendlify(hash.dig("_data", key, "friendly_name")) : friendlify(key)
      _fields[key]["text"] = text(name, main_x, layout_y(true))
      _fields[key]["value"] = "N/A"
      value = "N/A" if value == 0
      _fields[key]["data"] = text(value, data_x, layout_y(true))
      layout_y
    end

    return _fields
  end

  def button_up(id)
    super
    switch_team(id, self.class, :match)
  end
end
