class ScoutTeamContainer < Container
  def setup
    @allow_recreation_on_resize = false
    self.text_color = Gosu::Color::BLACK

    text "Scout Team", 0, 10, 32, SCOUTING_HEADER_COLOR, :center

    if AppSync.team_number != 0 && AppSync.team_number != nil
      text "Autonomous", 0, 50, 25, AUTONOMOUS_HEADER_COLOR, :left
      set_layout_y(80, 47)

      auto_fields = scouting_fields(AppSync.schema.scouting_autonomous, :left)


      text "Teleop", 0, 50, 25, TELEOP_HEADER_COLOR, :right
      set_layout_y(80, 47)

      teleop_fields = scouting_fields(AppSync.schema.scouting_teleop, :right)
    else
      text "No team selected.", 0, 50, 32, text_color, :center
    end
  end

  def scouting_fields(array, side)
    fields = {}
    array.each do |field|
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
        default = ""
        default = fields[key]["field"]["default"] if fields[key]["field"]["default"] != nil
        fields[key]["input"] = input(default, x_position, relative_y(value["text"].y)-BUTTON_PADDING)
      when "number"
        default = 0
        default = fields[key]["field"]["default"] if fields[key]["field"]["default"] != nil
        fields[key]["input"] = input(default, x_position, relative_y(value["text"].y)-BUTTON_PADDING, BUTTON_PADDING*3, 22)
      when "boolean"
        default = false
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
#     if AppSync.team_number != 0 && AppSync.team_number != nil
#       text "Autonomous", 0, 50, 25, AUTONOMOUS_HEADER_COLOR, :left
#       set_layout_y(80, 47)
#       _j = text "Can Score Jewel", 0, layout_y, 22, text_color, :left
#       _g = text "Can Score Glyphs", 0, layout_y, 22, text_color, :left
#       _c = text "Can Read Cryptobox Key", 0, layout_y, 22, text_color, :left
#       _s = text "Max Glyphs Scorable", 0, layout_y, 22, text_color, :left
#       _p = text "Can Park in Safe Zone", 0, layout_y, 22, text_color, :left
#       _a = text "Has Autonomous", 0, layout_y, 22, text_color, :left
#       _n = text "Autonomous Notes", 0, layout_y, 22, text_color, :left

#       texts = [_j, _g, _c, _s, _p, _a, _n]
#       widest=_j
#       texts.each {|t| if t.width+t.x > widest.width+widest.x; widest = t; end}

#       auto_can_score_jewel       = check_box(relative_x(widest.x)+widest.width+BUTTON_PADDING, relative_y(_j.y)-BUTTON_PADDING)
#       auto_can_score_in_cryptobox= check_box(relative_x(widest.x)+widest.width+BUTTON_PADDING, relative_y(_g.y)-BUTTON_PADDING)
#       auto_can_read_cryptobox_key= check_box(relative_x(widest.x)+widest.width+BUTTON_PADDING, relative_y(_c.y)-BUTTON_PADDING)
#       auto_max_glyphs_scorable   = input("0", relative_x(widest.x)+widest.width+BUTTON_PADDING, relative_y(_s.y)-BUTTON_PADDING, 25+BUTTON_PADDING, 22)
#       auto_can_park_in_safe_zone = check_box(relative_x(widest.x)+widest.width+BUTTON_PADDING, relative_y(_p.y)-BUTTON_PADDING)
#       auto_has_autonomous        = check_box(relative_x(widest.x)+widest.width+BUTTON_PADDING, relative_y(_a.y)-BUTTON_PADDING, true)
#       auto_autonomous_notes      = input("", relative_x(widest.x)+widest.width+BUTTON_PADDING, relative_y(_n.y)-BUTTON_PADDING, Input::WIDTH, 22)


#       text "TeleOp", 0, 50, 25, TELEOP_HEADER_COLOR, :right
#       set_layout_y(80, 47)
#       _g = text "Can Score Glyphs", 0, layout_y, 22, text_color, :right
#       _s = text "Max Glyphs Scorable", 0, layout_y, 22, text_color, :right
#       _c = text "Can Complete Cipher", 0, layout_y, 22, text_color, :right
#       _r = text "Can Score Relic", 0, layout_y, 22, text_color, :right
#       _r1 = text "Relic Zone 1", 0, layout_y, 22, text_color, :right
#       _r2 = text "Relic Zone 2", 0, layout_y, 22, text_color, :right
#       _r3 = text "Relic Zone 3", 0, layout_y, 22, text_color, :right
#       _u = text "Can Place Relic Upright", 0, layout_y, 22, text_color, :right
#       _b = text "Can Balance on Stone", 0, layout_y, 22, text_color, :right
#       _n = text "TeleOp Notes", 0, layout_y, 22, text_color, :right

#       texts = [_g, _s, _c, _r, _u, _b, _r, _r1, _r2, _r3, _n]
#       widest=_g
#       texts.each {|t| if t.width+t.x > widest.width+widest.x; widest = t; end}

#       tele_can_score_in_cryptobox  = check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_g.y)-BUTTON_PADDING)
#       tele_max_glyphs_scorable     = input("0",relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_s.y)-BUTTON_PADDING, 25+BUTTON_PADDING, 22)
#       tele_can_complete_cipher     = check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_c.y)-BUTTON_PADDING)
#       tele_can_score_relic         = check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_r.y)-BUTTON_PADDING)
#       tele_relic_zone_1            = check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_r1.y)-BUTTON_PADDING)
#       tele_relic_zone_2            = check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_r2.y)-BUTTON_PADDING)
#       tele_relic_zone_3            = check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_r3.y)-BUTTON_PADDING)
#       tele_can_place_relic_upright = check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_u.y)-BUTTON_PADDING)
#       tele_can_balance_on_stone    = check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_b.y)-BUTTON_PADDING)
#       tele_teleop_notes            = input("",(relative_x(widest.x)-(widest.width))-Input::WIDTH+(BUTTON_PADDING*8), relative_y(_n.y)-BUTTON_PADDING, Input::WIDTH, 22)

#       if File.exists?("./data/#{AppSync.team_number}/autonomous.json")
#         auto = JSONMiddleWare.load(open("./data/#{AppSync.team_number}/autonomous.json").read)
#         if auto["has_autonomous"]
#           auto_can_score_jewel.checked = auto["can_score_jewel"]
#           if auto["can_score_in_cryptobox"]
#             auto_can_score_in_cryptobox.checked  = true
#             auto_max_glyphs_scorable.text = auto["max_glyphs_scorable"]
#           end
#           auto_can_read_cryptobox_key.checked = auto["can_read_cryptobox_key"]
#           auto_can_park_in_safe_zone.checked  = auto["can_park_in_safe_zone"]
#           auto_autonomous_notes.text          = auto["autonomous_notes"]
#         else
#           auto["has_autonomous"].checked = false
#         end
#       end

#       if File.exists?("./data/#{AppSync.team_number}/teleop.json")
#         teleop = JSONMiddleWare.load(open("./data/#{AppSync.team_number}/teleop.json").read)
#         tele_can_score_in_cryptobox.checked = teleop["can_score_in_cryptobox"]
#         # Fixed an error I made when update TAE that poured into TAE-C
#         tele_max_glyphs_scorable.text = teleop["max_scorable_glyphs"] unless teleop["max_scorable_glyphs"] == nil
#         tele_max_glyphs_scorable.text = teleop["max_glyphs_scorable"] if teleop["max_scorable_glyphs"] == nil
#         tele_can_complete_cipher.checked = teleop["can_complete_cipher"]
#         if teleop["can_score_relic"]
#           tele_can_score_relic.checked = true
#           tele_relic_zone_1.checked = teleop["relic_zone_1"]
#           tele_relic_zone_2.checked = teleop["relic_zone_2"]
#           tele_relic_zone_3.checked = teleop["relic_zone_3"]
#           tele_can_place_relic_upright.checked = teleop["relic_upright"]
#         end
#         tele_can_balance_on_stone.checked = teleop["can_balance_on_stone"]
#         tele_teleop_notes.text = teleop["teleop_notes"]
#       end

#       button("Save", $window.width/2-0, relative_y(_b.y+22+(BUTTON_PADDING*8))) do
#         # Do science
#         autonomous_hash = {}
#         teleop_hash      = {}

#         unless File.directory?("./data/#{AppSync.team_number}")
#           Dir.mkdir("./data/#{AppSync.team_number}")
#           puts "Created directory"
#         end

#         autonomous_hash["can_score_jewel"]        = auto_can_score_jewel.checked        # Boolean
#         autonomous_hash["can_score_in_cryptobox"] = auto_can_score_in_cryptobox.checked # Boolean
#         autonomous_hash["can_read_cryptobox_key"] = auto_can_read_cryptobox_key.checked # Boolean
#         autonomous_hash["max_glyphs_scorable"]    = auto_max_glyphs_scorable.text.to_i  # Integer
#         autonomous_hash["can_park_in_safe_zone"]  = auto_can_park_in_safe_zone.checked  # Boolean
#         autonomous_hash["has_autonomous"]         = auto_has_autonomous.checked         # Boolean
#         autonomous_hash["autonomous_notes"]       = auto_autonomous_notes.text          # String
#         auto_json = JSONMiddleWare.dump(autonomous_hash)
#         File.open("./data/#{AppSync.team_number}/autonomous.json", "w") do |f|
#           f.write auto_json
#         end

#         teleop_hash["can_score_in_cryptobox"] = tele_can_score_in_cryptobox.checked  # Boolean
#         teleop_hash["max_glyphs_scorable"]    = tele_max_glyphs_scorable.text.to_i   # Integer
#         teleop_hash["can_complete_cipher"]    = tele_can_complete_cipher.checked     # Boolean
#         teleop_hash["can_score_relic"]        = tele_can_score_relic.checked         # Boolean
#         teleop_hash["relic_zone_1"]           = tele_relic_zone_1.checked            # Boolean
#         teleop_hash["relic_zone_2"]           = tele_relic_zone_2.checked            # Boolean
#         teleop_hash["relic_zone_3"]           = tele_relic_zone_3.checked            # Boolean
#         teleop_hash["relic_upright"]          = tele_can_place_relic_upright.checked # Boolean
#         teleop_hash["can_balance_on_stone"]   = tele_can_balance_on_stone.checked    # Boolean
#         teleop_hash["teleop_notes"]           = tele_teleop_notes.text               # String
#         teleop_json = JSONMiddleWare.dump(teleop_hash)
#         File.open("./data/#{AppSync.team_number}/teleop.json", "w") do |f|
#           f.write teleop_json
#         end

#         $window.active_container = ScoutingContainer.new
#       end
#     else
#       text "No team selected.", 0, 50, 32, text_color, :center
#     end
#   end
# end
