class Schema

  def initialize(schema_file, expected_spec_version = 1)
    @expected_spec_version = expected_spec_version
    begin
      @data = JSONMiddleWare.load( File.open(schema_file).read )
      @failed = true if @data.dig("spec_version").nil?
      @failed = true if @data.dig("season").nil?
      @failed = true if @data.dig("match_autonomous").nil?
      @failed = true if @data.dig("match_teleop").nil?
      @failed = true if @data.dig("scouting_autonomous").nil?
      @failed = true if @data.dig("scouting_teleop").nil?

      raise "Expected Schema Spec version #{expected_spec_version} not #{spec}" if expected_spec_version != spec

      @failed ||= false

    rescue Errno::ENOENT => e
      puts "File not found"
      @data = Hash.new
      @failed = true
    end

  end

  def failed
    @failed
  end

  def spec
    d = @data.dig("spec_version")
    d ? d : 0
  end

  def season
    d = @data.dig("season")
    d ? d : "[Schema LoadError]"
  end

  def match_autonomous
    d = @data.dig("match_autonomous")
    d ? d : {}
  end

  def match_teleop
    d = @data.dig("match_teleop")
    d ? d : {}
  end

  def scouting_autonomous
    d = @data.dig("scouting_autonomous")
    d ? d : {}
  end

  def scouting_teleop
    d = @data.dig("scouting_teleop")
    d ? d : {}
  end
end