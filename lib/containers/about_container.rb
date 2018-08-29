class AboutContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK
    main_x = ($window.width/4)*1#250
    data_x = ($window.width/4)*2.7#650

    set_layout_y(Text::SIZE_HEADER, Text::SIZE)
    text "About", 0, 10, Text::SIZE_HEADER, ABOUT_HEADER_COLOR, :center

    text "#{Window::NAME}", main_x, layout_y, Text::SIZE_HEADING, text_color, :center
    if (Time.now.year-2017) < 70
      @copyright_year = "2017-#{Time.now.year}"
    else
      @copyright_year = 2017
    end
    text "Copyright © #{@copyright_year} Matthew \"Cyberarm\" Larson.", main_x, layout_y, Text::SIZE, text_color, :center
    t=text "Licensed under the MIT open source license.", main_x, layout_y, Text::SIZE, text_color, :center

    button "Website", main_x, layout_y(true), "https://TimeCrafters.org/analytical-engine-companion" do
      Launchy.open("https://TimeCrafters.org/analytical-engine-companion")
    end

    button "Source Code", $window.width/2-t.textobject.text_width("Source Code")/2, layout_y(true), "https://github.com/TimeCrafters/TimeCraftersAnalyticalEngineCompanion" do
      Launchy.open("https://github.com/TimeCrafters/TimeCraftersAnalyticalEngineCompanion")
    end
    button "MIT License", data_x, layout_y, "https://opensource.org/licenses/MIT" do
      Launchy.open("https://opensource.org/licenses/MIT")
    end
    layout_y
    layout_y
    text "Legal Notices", main_x, layout_y, Text::SIZE_HEADING, text_color, :center

    list = Gosu::LICENSES.split("\n")
    text list.shift, main_x, layout_y
    text list.shift, main_x, layout_y

    list.each do |l|
      data = l.split(",")
      text data.first, main_x, layout_y(true)
      i = button data[2], data_x, layout_y(true), data[3] do
        Launchy.open(data[3])
      end
      button "Website", data_x-(BUTTON_PADDING*10), layout_y(true), data[1] do
        Launchy.open(data[1])
      end
      layout_y
      layout_y
    end
  end
end
