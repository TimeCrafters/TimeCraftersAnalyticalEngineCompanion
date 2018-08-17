class ScoutTeamContainer < Container
  def setup
    @allow_recreation_on_resize = false
    self.text_color = Gosu::Color::BLACK

    text "Scout Team", 0, 10, 32, SCOUTING_HEADER_COLOR, :center

    if AppSync.team_number != 0 && AppSync.team_number != nil
      if !AppSync.schema.failed
        text "Autonomous", 0, 50, 25, AUTONOMOUS_HEADER_COLOR, :left
        set_layout_y(80, 47)

        auto_fields = scouting_fields(AppSync.schema.scouting_autonomous, :left, "autonomous")


        text "Teleop", 0, 50, 25, TELEOP_HEADER_COLOR, :right
        set_layout_y(80, 47)

        teleop_fields = scouting_fields(AppSync.schema.scouting_teleop, :right, "teleop")

        last_element =  teleop_fields.values[teleop_fields.size-1]["text"]

        button("Save", $window.width/2-0, relative_y(last_element.y+last_element.height+(BUTTON_PADDING*2))) do
          # Do science
          autonomous_hash = {}
          teleop_hash      = {}

          unless File.directory?("./data/#{AppSync.team_number}")
            Dir.mkdir("./data/#{AppSync.team_number}")
            puts "Created directory"
          end

          auto_fields.each do |key, value|
            case value["field"]["type"]
            when "string"
              autonomous_hash[value["field"]["name"]] = value["input"].text
            when "number"
              autonomous_hash[value["field"]["name"]] = value["input"].text.to_i
            when "boolean"
              autonomous_hash[value["field"]["name"]] = value["input"].checked
            end
          end

          File.open("./data/#{AppSync.team_number}/autonomous.json", "w") {|f| f.write JSONMiddleWare.dump(autonomous_hash)}

          teleop_fields.each do |key, value|
            case value["field"]["type"]
            when "string"
              teleop_hash[value["field"]["name"]] = value["input"].text
            when "number"
              teleop_hash[value["field"]["name"]] = value["input"].text.to_i
            when "boolean"
              teleop_hash[value["field"]["name"]] = value["input"].checked
            end
          end

          File.open("./data/#{AppSync.team_number}/teleop.json", "w") {|f| f.write JSONMiddleWare.dump(teleop_hash)}

          $window.active_container = ScoutingContainer.new
        end
      else
        text "Missing or broken schema.", 0, 50, 32, text_color, :center
      end
    else
      text "No team selected.", 0, 50, 32, text_color, :center
    end
  end

  def scouting_fields(array, side, period)
    fields = {}
    array.each_with_index do |field, index|
      if field["name"].nil? && field["type"].nil?
        field["friendly_name"] = "Schema broken for \"scouting_#{period}\", element #{index}, missing 'type' and 'name'"
      elsif field["name"].nil?
        field["friendly_name"] = "Schema broken for \"scouting_#{period}\", element #{index}, missing 'name'"
      elsif field["type"].nil?
        field["friendly_name"] = "Schema broken for \"scouting_#{period}\", element #{index}, missing 'type'"
      end

      fields[field] = {}
      fields[field]["field"] = field

      if field["friendly_name"]
        fields[field]["text"] = text field["friendly_name"], 0, layout_y, 22, text_color, side
      else
        fields[field]["text"] = text friendlify(field["name"]), 0, layout_y, 22, text_color, side
      end

      raise if fields[field]["text"].nil?
    end

    widest = nil
    fields.each do |key, value|
      widest = value["text"] if widest.nil?
      widest = value["text"] if value["text"].width + value["text"].x > widest.width + value["text"].x
    end

    data = {}
    if File.exists?("./data/#{AppSync.team_number}/autonomous.json")
      data = JSONMiddleWare.load(open("./data/#{AppSync.team_number}/#{period}.json").read)
    end

    fields.each do |key, value|
      x_position = 0
      if side == :left
        x_position = relative_x(widest.x)+widest.width+BUTTON_PADDING
      elsif side == :right
        x_position = relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4))
      else
        raise "side is invalid: got #{side} expected :left or :right"
      end

      case value["field"]["type"]
      when "string"
        default = data[fields[key]["field"]["name"]] ? data[fields[key]["field"]["name"]] : ""
        default = fields[key]["field"]["default"] if fields[key]["field"]["default"] != nil
        fields[key]["input"] = input(default, x_position, relative_y(value["text"].y)-BUTTON_PADDING)
      when "number"
        default = data[fields[key]["field"]["name"]] ? data[fields[key]["field"]["name"]] : 0
        default = fields[key]["field"]["default"] if fields[key]["field"]["default"] != nil
        fields[key]["input"] = input(default, x_position, relative_y(value["text"].y)-BUTTON_PADDING, BUTTON_PADDING*3, 22)
      when "boolean"
        default = data[fields[key]["field"]["name"]] ? data[fields[key]["field"]["name"]] : false
        default = fields[key]["field"]["default"] if fields[key]["field"]["default"] != nil
        fields[key]["input"] = check_box(x_position, relative_y(value["text"].y)-BUTTON_PADDING, default)
      end
    end

    return fields
  end

  def friendlify(string)
    string.split("_").map {|s| s.capitalize}.join(" ")
  end
end