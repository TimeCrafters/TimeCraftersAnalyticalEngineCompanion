class Schema

  def initialize(schema_file, expected_spec_version = 1)
    @expected_spec_version = expected_spec_version
    @data = JSONMiddleWare.load( File.open(schema_file).read )

    raise "Expected Schema Spec version #{expected_spec_version} not #{spec}" if expected_spec_version != spec
  end

  def spec
    @data["spec_version"]
  end

  def season
    @data["season"]
  end

  def match_autonomous
    @data["match_autonomous"]
  end

  def match_teleop
    @data["match_teleop"]
  end

  def scouting_autonomous
    @data["scouting_autonomous"]
  end

  def scouting_teleop
    @data["scouting_teleop"]
  end
end