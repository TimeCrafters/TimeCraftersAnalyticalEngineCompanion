class AutonomousContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK
    @matches = []

    text "Autonomous", 0, 10, Text::SIZE_HEADER, AUTONOMOUS_HEADER_COLOR, :center
    @matches = AppSync.team_match_data

    if AppSync.team_has_match_data?
      main_x = ($window.width/4)*1#250
      data_x = ($window.width/4)*2.7#650

      set_layout_y(100, Text::SIZE)

      tally_match = MatchLoader::Match.new
      populate_fields(tally_match.autonomous)
      _x = 10
      _y = Text::SIZE_HEADER
      @matches.each_with_index do |match, index|

        b = button "Match #{index+1}", _x, _y do
        end

        _x+=b.width+10
        if (index+1).to_f/2 % 1 == 0
          _x = 10
          _y+=50
        end
      end

      all_matches = button "All Matches", 200, Text::SIZE_HEADER do
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

  def populate_fields(hash)
    p hash
    main_x = ($window.width/4)*1#250
    data_x = ($window.width/4)*2.7#650
    @fields = {}

    hash.each do |key, value|
      next if key == "_data"

      @fields[key] = {}
      name = hash.dig("_data", key, "friendly_name") ? friendlify(hash.dig("_data", key, "friendly_name")) : friendlify(key)
      @fields[key]["text"] = text(name, main_x, layout_y(true))
      @fields[key]["value"] = "N/A"
      puts "#{key}: #{value}"
      @fields[key]["data"] = text(value, data_x, layout_y(true))
      layout_y
    end
  end

  def button_up(id)
    super
    switch_team(id, self.class, :match)
  end
end
