class AppSync
  def self.team_number=(number)
    @team_number = number
  end
  def self.team_number
    @team_number
  end
  def self.team_name=(team)
    @team_name = name
  end
  def self.team_name
    @team_name
  end

  def self.team_has_scouting_data?
    false
  end

  def self.team_scouting_data(period)
  end

  def self.teams_list=(filename)
    @teams_list = {}
    File.open(filename) do |f|
      f.each do |line|
        list = line.split(" ")
        i = list.first.to_i
        if i == 0; next; end

        @teams_list[i] = list[1..list.count-1]
      end
    end
  end

  def teams_list
    @teams_list
  end
end
