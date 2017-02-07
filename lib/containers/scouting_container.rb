class ScoutingContainer < Container
  def setup
    if AppSync.team_has_scouting_data?
      AppSync.team_scouting_data("autonomous")
      AppSync.team_scouting_data("teleop")
    end

    text "Scouting Data", 0, 0, 100
  end

  def draw
    # fill(Gosu::Color.rgb(35, 16, 29))
    super
  end
end
