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
  class Match
    def initialize
      @hash = {}
      create_struct_from_schema
      return self
    end

    def create_struct_from_schema
      create_from(AppSync.schema.match_autonomous, :autonomous)
      create_from(AppSync.schema.match_teleop, :teleop)
    end

    def create_from(schema, period)
      period = period.to_s
      @hash[period] = {} unless @hash[period]
      @hash[period]["_data"] = {} unless @hash[period]["_data"]

      schema.each do |type, array|
        array.each do |hash|
          hash.each do |subtype, data|
            data.each do |location, v|
              if location.length == 0
                @hash[period]["#{type}_#{subtype}"] = 0#type_default(v)
                @hash[period]["_data"]["#{type}_#{subtype}"] = v
              else
                @hash[period]["#{type}_#{subtype}_#{location}"] = 0#type_default(v)
                @hash[period]["_data"]["#{type}_#{subtype}_#{location}"] = v

              end
            end
          end
        end
      end

      def autonomous
        @hash["autonomous"]
      end

      def teleop
        @hash["teleop"]
      end
    end

    def type_default(hash)
      if !hash.is_a?(Hash)
        p hash
        raise "hash is not a Hash"
      end
      if hash["default"]
        return hash["default"]
      else
        case hash["type"]
        when "number"
          return 0
        when "boolean"
          return false
        when "string"
          return ""
        end
      end
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
      raise
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
        if event_struct.location.length == 0
          autonomous_period.autonomous["#{event_struct.type}_#{event_struct.subtype}"] += 1
        else
          autonomous_period.autonomous["#{event_struct.type}_#{event_struct.subtype}_#{event_struct.location}"] += 1
        end
      elsif event_struct.period == "teleop"
        if event_struct.location.length == 0
          teleop_period.teleop["#{event_struct.type}_#{event_struct.subtype}"] += 1
        else
          teleop_period.teleop["#{event_struct.type}_#{event_struct.subtype}_#{event_struct.location}"] += 1
        end
      else
        puts "Unknown period: #{event_struct.period}"
      end

      @events.push(event_struct)
    end

    @autonomous = autonomous_period.autonomous
    @teleop     = teleop_period.teleop
  end
end
