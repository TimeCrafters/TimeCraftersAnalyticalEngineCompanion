require "gosu"
begin
  require "oj"
  USE_INTERNAL_JSON = false
rescue LoadError
  require "json"
  USE_INTERNAL_JSON = true
end

Mouse = Struct.new(:x, :y)

require_relative "lib/json_middleware"
require_relative "lib/match"
require_relative "lib/scouting"
require_relative "lib/text"
require_relative "lib/button"
require_relative "lib/window"

Window.new.show
