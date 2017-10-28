class ScoutTeamContainer < Container
  def setup
    text("Scout Team", 0,20, 35, Gosu::Color::BLACK, :center)
    input("INPUT", 200,20, Input::WIDTH, 35)
    check_box(200, 80)
  end
end
