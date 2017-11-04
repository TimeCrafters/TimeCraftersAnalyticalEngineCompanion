class AppSync
  def self.team_number=(number)
    @team_number = number
  end
  def self.team_number
    @team_number ||= 0
  end
  def self.team_name=(team)
    @team_name = team
  end
  def self.team_name
    @team_name ||= ""
  end

  def self.team_has_scouting_data?(number = @team_number)
    files = Dir.glob("./data/#{number}/*.json")
    if files.count > 0
      true
    else
      false
    end
  end

  def self.team_scouting_data(period)
    begin
      return JSONMiddleWare.load(File.open("./data/#{@team_number}/#{period}.json").read)
    rescue Errno::ENOENT => e
      puts "Error: #{e}"
      return Hash.new(nil)
    end
  end

  def self.team_has_match_data?(number = @team_number)
    files = Dir.glob("./data/#{number}/matches/*.json")
    if files.count > 0
      true
    else
      false
    end
  end

  def self.team_match_data
    matches = []
    files = Dir.glob("./data/#{@team_number}/matches/*.json")
    if files.count > 0
      files.each do |file|
        matches.push(MatchLoader.new(file))
      end
    end

    return matches
  end

  def self.teams_list=(filename)
    @teams_list = {}
    if ARGV.join.include?("--no-teamslist")
    else
      File.open(filename) do |f|
        f.each do |line|
          list = line.split(" ")
          i = list.first.to_i
          if i == 0; next; end

          @teams_list[i] = list[1..list.count-1].join(" ").strip
        end
      end
    end
  end

  def self.teams_list
    if @teams_list
      return @teams_list
    else
      return []
    end
  end

  def self.active_team(team_number)
    @team_number = team_number
    @team_name   = @teams_list[team_number]
  end
end
