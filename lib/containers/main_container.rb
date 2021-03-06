class MainContainer < Container
  def setup
    @logo_image = Gosu::Image.new("./media/TimeCraftersLogo.png")
    self.text_color = Gosu::Color::BLACK
    _x = 10
    _y = 70
    _b = nil
    dataless_teams = 0
    AppSync.teams_list.each do |number, name|
      if AppSync.team_has_scouting_data?(number) or AppSync.team_has_match_data?(number)
        b = button("#{number}", _x, _y, "#{name}") do
          AppSync.active_team(number)
          $window.active_container = ScoutingContainer.new
        end

        if number == 10432; b.text.color = Gosu::Color.rgb(40, 100, 40); end
        _x+=b.width+20

        if _x > $window.width
          _x = 10
          _y+= 45
        end
      else
        b = button("#{number}", _x, _y, "#{name}") do
          AppSync.active_team(number)
          $window.active_container = ScoutingContainer.new
        end
        b.text.color = Gosu::Color.rgb(200, 200, 255)
        if number == 10432; b.text.color = Gosu::Color.rgb(40, 100, 40); end
        _x+=b.width+20

        if _x+b.width > $window.width
          _x = 10
          _y+= 45
        end
      end
    end

    if RUBY_PLATFORM =~ /mingw|mswin/i
      button "Open Data Folder", 10, 10 do
        system("explorer #{Dir.pwd.gsub('/', '\\')}\\data")
      end
    end

    if AppSync.teams_list.count == 0 && !$window.need_teams_list_selector# Assumed to be a first time user
      set_layout_y(70, 30)
      text "Welcome", 0, 10, 60, text_color, :center
      text "The #{Window::NAME}", 0, layout_y, 30, text_color, :center
      text "is meant to be used as a desktop viewer for data", 0, layout_y, 30, text_color, :center
      text "gathered from the Android application.", 0, layout_y, 30, text_color, :center
      text "", 0, layout_y, 30, text_color, :center
      text "If you granted write permissions to the application", 0, layout_y, 30, text_color, :center
      text "then you can find the data on the phone in:", 0, layout_y, 30, text_color, :center
      text "/TimeCraftersAnalyticalEngine", 0, layout_y, 30, text_color, :center
      text "", 0, layout_y, 30, text_color, :center
      text "Place the contents of the 'competition' folder in ./data", 0, layout_y, 30, text_color, :center
      text "Place the Teams List in ./data", 0, layout_y, 30, text_color, :center
      text "", 0, layout_y, 30, text_color, :center
      text "Enjoy. :)", 0, layout_y, 30, text_color, :center
      text "", 0, layout_y, 30, text_color, :center
      text "TimeCrafters.org".unpack("b*").join, 0, self.height-20, 19, text_color, :center

    elsif AppSync.teams_list.count == 0 && $window.need_teams_list_selector
      set_layout_y(70, 50)
      text "Almost Ready", 0, 10, 60, text_color, :center
      text "Multiple team lists were detected, please select one to use:", 0, layout_y, 30, text_color, :center
      $window.list_search_results.sort.each do |list|
        count = open(list).read.split("\n").count
        button(list.split("/").last, 250, layout_y, "Has #{count} teams") { AppSync.teams_list=list; $window.active_container = self.class.new }
      end
    end
    if dataless_teams >= AppSync.teams_list.count && AppSync.teams_list.count != 0
      text "No Data for Teams", 0, 10, 32, BAD_COLOR, :center
    end

    if AppSync.teams_list.count >= dataless_teams && AppSync.teams_list.count > 0
      text "Select a Team", 0, 10, 32, Gosu::Color::BLACK, :center
    end
  end

  def draw
    if AppSync.teams_list.count == 0 && !$window.need_teams_list_selector
      @logo_image.draw($window.width-412,100,0, 0.5, 0.5, Gosu::Color.rgb(0,128,0))
      @logo_image.draw(412,100,0, -0.5, 0.5, Gosu::Color.rgb(0,128,0))
    elsif AppSync.teams_list.count == 0 && $window.need_teams_list_selector
      @logo_image.draw($window.width-412,100,0, 0.5, 0.5, Gosu::Color.rgb(255,0,255))
      @logo_image.draw(412,100,0, -0.5, 0.5, Gosu::Color.rgb(255,0,255))
    end
    super
  end
end
