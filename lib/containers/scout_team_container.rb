class ScoutTeamContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK

    text "Scout Team", 0, 10, 32, SCOUTING_HEADER_COLOR, :center

    if AppSync.team_number != 0 && AppSync.team_number != nil
      text "Autonomous", 0, 50, 25, AUTONOMOUS_HEADER_COLOR, :left
      set_layout_y(80, 47)
      _j = text "Can Score Jewel", 0, layout_y, 22, text_color, :left
      _g = text "Can Score Glyphs", 0, layout_y, 22, text_color, :left
      _c = text "Can Read Cryptobox Key", 0, layout_y, 22, text_color, :left
      _s = text "Max Glyphs Scorable", 0, layout_y, 22, text_color, :left
      _p = text "Can Park in Safe Zone", 0, layout_y, 22, text_color, :left

      texts = [_j, _g, _c, _s, _p]
      widest=_j
      texts.each {|t| if t.width+t.x > widest.width+widest.x; widest = t; end}

      check_box(relative_x(widest.x)+widest.width+BUTTON_PADDING, relative_y(_j.y)-BUTTON_PADDING)
      check_box(relative_x(widest.x)+widest.width+BUTTON_PADDING, relative_y(_g.y)-BUTTON_PADDING)
      check_box(relative_x(widest.x)+widest.width+BUTTON_PADDING, relative_y(_c.y)-BUTTON_PADDING)
      input("0", relative_x(widest.x)+widest.width+BUTTON_PADDING, relative_y(_s.y)-BUTTON_PADDING, 25+BUTTON_PADDING, 22)
      check_box(relative_x(widest.x)+widest.width+BUTTON_PADDING, relative_y(_p.y)-BUTTON_PADDING)


      text "TeleOp", 0, 50, 25, TELEOP_HEADER_COLOR, :right
      set_layout_y(80, 47)
      _g = text "Can Score Glyphs", 0, layout_y, 22, text_color, :right
      _s = text "Max Glyphs Scorable", 0, layout_y, 22, text_color, :right
      _c = text "Can Complete Cipher", 0, layout_y, 22, text_color, :right
      _r = text "Can Score Relic [1,2,3]", 0, layout_y, 22, text_color, :right
      _u = text "Can Place Relic Upright", 0, layout_y, 22, text_color, :right
      _b = text "Can Balance on Stone", 0, layout_y, 22, text_color, :right

      texts = [_g, _s, _c, _r, _u, _b]
      widest=_g
      texts.each {|t| if t.width+t.x > widest.width+widest.x; widest = t; end}

      check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_g.y)-BUTTON_PADDING)
      input("0",relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_s.y)-BUTTON_PADDING, 25+BUTTON_PADDING, 22)
      check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_c.y)-BUTTON_PADDING)
      check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_r.y)-BUTTON_PADDING)
      check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_u.y)-BUTTON_PADDING)
      check_box(relative_x(widest.x)-(widest.width-(BUTTON_PADDING*4)), relative_y(_b.y)-BUTTON_PADDING)

      button("Save", $window.width/2-0, relative_y(_b.y+22+(BUTTON_PADDING*2))) do
        # Do science
      end
    else
      text "No team selected.", 0, 50, 32, text_color, :center
    end
  end
end
