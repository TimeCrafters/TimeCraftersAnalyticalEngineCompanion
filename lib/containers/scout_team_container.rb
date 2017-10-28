class ScoutTeamContainer < Container
  def setup
    text "Scout Team", 0, 10, 32, SCOUTING_HEADER_COLOR, :center
    input("INPUT", 200,20, Input::WIDTH, 35)
    check_box(200, 80)
  end
end
