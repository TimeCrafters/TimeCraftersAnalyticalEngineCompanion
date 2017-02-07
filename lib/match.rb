class Match
  attr_reader :data

  def initialize(filename)
    begin
      parse(filename)
    rescue
      puts "Error"
    end
  end

  def parse(json)
    events = []
    File.open(filename).each do |line|
      events.push(JSONMiddleWare.load(line))
    end

    events.each do |event|
      event["period"]
    end
  end
end
