class MatchLoader
  Event = Struct.new(:team, :period, :type, :subtype, :location, :points, :description) do
    def initialize(*)
      super
      self.team        ||= 10432
      self.period      ||= ""
      self.type        ||= ""
      self.subtype     ||= ""
      self.location    ||= ""
      self.points      ||= 0
      self.description ||= ""
    end
  end
  Match = Struct.new(:beacons_claimed, :beacons_missed, :beacons_stolen,
                    :scored_in_vortex, :scored_in_corner, :missed_vortex, :missed_corner,
                    :completely_on_platform, :completely_on_ramp, :on_platform, :on_ramp,
                    :capball_on_floor, :capball_missed, :capball_off_floor, :capball_above_crossbar, :capball_capped,
                    :is_capball_off_floor, :is_capball_on_floor, :is_capball_above_crossbar, :is_capball_capped,
                    :is_dead_robot) do
    def initialize(*)
      super
      self.beacons_claimed ||= 0
      self.beacons_missed  ||= 0
      self.beacons_stolen  ||= 0

      self.scored_in_vortex ||= 0
      self.scored_in_corner ||= 0
      self.missed_vortex ||= 0
      self.missed_corner ||= 0
      self.missed_corner ||= 0

      self.completely_on_platform ||= 0
      self.completely_on_ramp     ||= 0
      self.on_platform            ||= 0
      self.on_ramp                ||= 0

      self.capball_missed         ||= 0
      self.capball_on_floor       ||= 0
      self.capball_off_floor      ||= 0
      self.capball_above_crossbar ||= 0
      self.capball_capped         ||= 0

      self.is_capball_on_floor       ||= false
      self.is_capball_off_floor      ||= false
      self.is_capball_above_crossbar ||= false
      self.is_capball_capped         ||= false

      self.is_dead_robot ||= false
    end
  end
  attr_reader :data, :events

  def initialize(filename)
    @events = []

    begin
      parse(filename)
    rescue => e
      puts "Error: #{e}"
    end
  end

  def parse(filename)
    events = []
    File.open(filename).each do |line|
      events.push(JSONMiddleWare.load(line))
    end


    autonomous_period = Match.new
    teleop_period = Match.new

    events.each do |event|
      event_struct = Event.new

      event_struct.team = event["team"]
      event_struct.period = event["period"]
      event_struct.type = event["type"]
      event_struct.subtype = event["subtype"]
      event_struct.location = event["location"]
      event_struct.points = event["points"]
      event_struct.description = event["description"]

      if event_struct.period == "autonomous"
        if event_struct.type == "score"
          if event_struct.subtype == "beacon"
            autonomous_period.beacons_claimed+=1
          end

          if event_struct.subtype == "particle"
            if event_struct.location == "vortex"
              autonomous_period.scored_in_vortex+=1
            elsif event_struct.location == "corner"
              autonomous_period.scored_in_corner+=1
            end
          end

          if event_struct.subtype == "parking"
            if event_struct.location == "on_platform"
              autonomous_period.completely_on_platform+=1
            elsif event_struct.location == "on_ramp"
              autonomous_period.completely_on_ramp+=1
            elsif event_struct.location == "platform"
              autonomous_period.platform+=1
            elsif event_struct.location == "ramp"
              autonomous_period.ramp+=1
            end
          end

          if event_struct.subtype == "capball"
            if event_struct.location == "floor"
              autonomous_period.capball_on_floor+=1
            end
          end
        elsif event_struct.type == "miss"
        end
      elsif event_struct.period == "teleop"
      end

      @events.push(event_struct)
    end

    p autonomous_period
  end
end
