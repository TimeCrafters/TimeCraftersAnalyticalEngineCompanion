class AboutContainer < Container
  def setup
    self.text_color = Gosu::Color::BLACK
    set_layout_y(50, 22)
    text "About", 330, 10, 32
    text "Written by: Matthew Larson", 300, layout_y
    text "Written in: Ruby", 300, layout_y
    text "Uses: Ruby and Gosu", 300, layout_y
    text "Source: https://example.com/cyberarm/repo_name", 300, layout_y
    layout_y
    text "Legal Notices", 300, layout_y
    text "Copyright: © 2017 Matthew \"Cyberarm\" Larson. Licensed under the MIT open source license.", 10, layout_y
    text "License Text: https://opensource.org/licenses/MIT", 10, layout_y
    layout_y
    Gosu::LICENSES.split("\n").each do |l|
      text l, 10, layout_y
    end
  end
end
