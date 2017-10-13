class AboutContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK
    set_layout_y(50, 22)
    text "About", 0, 10, 32, Gosu::Color::BLACK, :center
    text "Written by: Matthew Larson", 300, layout_y, Text::SIZE, Gosu::Color::BLACK, :center
    text "Written in: Ruby", 300, layout_y, Text::SIZE, Gosu::Color::BLACK, :center
    text "Uses: Ruby and Gosu", 300, layout_y, Text::SIZE, Gosu::Color::BLACK, :center
    text "Website: https://TimeCrafters.org/analytical-engine", 300, layout_y, Text::SIZE, Gosu::Color::BLACK, :center
    layout_y
    text "Legal Notices", 300, layout_y, Text::SIZE, Gosu::Color::BLACK, :center
    text "Copyright: © 2017 Matthew \"Cyberarm\" Larson. Licensed under the MIT open source license.", 10, layout_y, Text::SIZE, Gosu::Color::BLACK, :center
    text "License Text: https://opensource.org/licenses/MIT", 10, layout_y, Text::SIZE, Gosu::Color::BLACK, :center
    layout_y
    Gosu::LICENSES.split("\n").each do |l|
      text l, 10, layout_y, Text::SIZE, Gosu::Color::BLACK, :center
    end
  end
end
