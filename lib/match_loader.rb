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
  Match = Struct.new(:jewel_scored, :jewel_missed,
                    :glyph_scored, :glyph_missed, :glyph_read_cryptobox_key,
                    :parked_in_safe_zone, :parking_missed,
                    :balanced_on_stone, :balancing_missed,
                    :relic_upright, :relic_zone_1, :relic_zone_2, :relic_zone_3, :relic_missed,
                    :dead_robot,
                    :is_dead_robot) do
    def initialize(*)
      super
      self.jewel_scored ||= 0
      self.jewel_missed ||= 0

      self.glyph_scored ||= 0
      self.glyph_missed ||= 0
      self.glyph_read_cryptobox_key ||= 0

      self.parked_in_safe_zone ||= 0
      self.parking_missed      ||= 0

      self.balanced_on_stone ||= 0
      self.balancing_missed  ||= 0

      self.relic_upright ||= 0
      self.relic_zone_1  ||= 0
      self.relic_zone_2  ||= 0
      self.relic_zone_3  ||= 0
      self.relic_missed  ||= 0

      self.dead_robot ||= 0

      self.is_dead_robot ||= false
    end
  end
  attr_reader :data, :events, :autonomous, :teleop

  def initialize(filename)
    @events = []
    @autonomous = nil
    @teleop     = nil

    begin
      parse(filename)
    rescue => e
      puts "Error: #{e}"
    end

    return self
  end

  def parse(filename)
    events = []
    File.open(filename).each do |line|
      events.push(JSONMiddleWare.load(line))
    end


    autonomous_period = Match.new
    teleop_period     = Match.new
    event_struct = Event.new

    events.each do |event|

      event_struct.team        = event["team"]
      event_struct.period      = event["period"]
      event_struct.type        = event["type"]
      event_struct.subtype     = event["subtype"]
      event_struct.location    = event["location"]
      event_struct.points      = event["points"]
      event_struct.description = event["description"]

      if event_struct.period == "autonomous"
        if event_struct.type == "scored"
          if event_struct.subtype == "jewel"
            autonomous_period.jewel_scored+=1
          end

          if event_struct.subtype == "glyph"
            if event_struct.location == "glyph"
              autonomous_period.glyph_scored+=1
            elsif event_struct.location == "cryptokey"
              autonomous_period.glyph_read_cryptobox_key+=1
            end
          end

          if event_struct.subtype == "parking"
            autonomous_period.parked_in_safe_zone+=1
          end

        elsif event_struct.type == "missed"
          if event_struct.subtype == "jewel"
            autonomous_period.jewel_missed+=1
          end

          if event_struct.subtype == "glyph"
            autonomous_period.glyph_missed+=1
          end

          if event_struct.subtype == "parking"
            autonomous_period.parking_missed+=1
          end

          if event_struct.subtype == "robot"
            autonomous_period.dead_robot+=1
            autonomous_period.is_dead_robot = true
          end
        end
      elsif event_struct.period == "teleop"
        if event_struct.type == "scored"
          if event_struct.subtype == "beacon"
            teleop_period.beacons_claimed+=1
          end

          if event_struct.subtype == "particle"
            if event_struct.location == "vortex"
              teleop_period.scored_in_vortex+=1
            elsif event_struct.location == "corner"
              teleop_period.scored_in_corner+=1
            end
          end

          if event_struct.subtype == "capball"
            if event_struct.location == "off_floor"
              teleop_period.capball_off_floor+=1
              teleop_period.is_capball_off_floor = true
            end
            if event_struct.location == "above_crossbar"
              teleop_period.capball_above_crossbar+=1
              teleop_period.is_capball_above_crossbar = true
            end
            if event_struct.location == "capped"
              teleop_period.capball_capped+=1
              teleop_period.is_capball_capped = true
            end
          end

        elsif event_struct.type == "missed"
          if event_struct.subtype == "beacon"
            teleop_period.beacons_missed+=1
          end

          if event_struct.subtype == "particle"
            if event_struct.location == "vortex"
              teleop_period.missed_vortex+=1
            elsif event_struct.location == "corner"
              teleop_period.missed_corner+=1
            end
          end

          if event_struct.subtype == "capball"
            teleop_period.capball_missed+=1
          end

          if event_struct.subtype == "robot"
            teleop_period.dead_robot+=1
            teleop_period.is_dead_robot = true
          end
        elsif event_struct.type == "lost"
          if event_struct.type == "beacon"
            teleop_period.beacons_stolen+=1
          end
        end
      end

      @events.push(event_struct)
    end

    @autonomous = autonomous_period
    @teleop     = teleop_period
  end
end
