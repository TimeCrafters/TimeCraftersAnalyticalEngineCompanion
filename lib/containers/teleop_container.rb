class TeleOpContainer < Container
  def setup
    text "TeleOp", 430, 10, 32, TELEOP_HEADER_COLOR

    button "All Matches", 10, 50
    button "Match 1",    140, 50
    button "Match 2",    240, 50
  end
end
