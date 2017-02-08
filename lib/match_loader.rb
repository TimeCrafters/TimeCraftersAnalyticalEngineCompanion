class MatchLoader
  Event = Struct.new(:team, :period, :type, :subtype, :location, :points, :description)
  Match = Struct.new(:beacons_claimed, :beacons_missed, :beacons_stolen,
                    :scored_in_vortex, :scored_in_corner, :missed_vortex, :missed_corner,
                    :completely_on_platform, :completely_on_corner, :on_platform, :on_ramp,
                    :capball_on_floor, :capball_missed, :capball_off_floor, :capball_above_crossbar, :capball_capped,
                    :is_capball_on_floor, :is_capball_above_crossbar, :is_capball_capped,
                    :is_dead_robot)
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


    events.each do |event|
      event_struct = Event.new

      event_struct.team = event["team"]
      event_struct.period = event["period"]
      event_struct.type = event["type"]
      event_struct.subtype = event["subtype"]
      event_struct.location = event["location"]
      event_struct.points = event["points"]
      event_struct.description = event["description"]

      puts event_struct
      @events.push(event_struct)
    end
  end
end
