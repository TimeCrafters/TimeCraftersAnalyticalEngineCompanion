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
require_relative "lib/schema"
require_relative "lib/appsync"
require_relative "lib/match_loader"

require_relative "lib/ui/text"
require_relative "lib/ui/button"
require_relative "lib/ui/input"
require_relative "lib/ui/check_box"
require_relative "lib/ui/container"

require_relative "lib/containers/home_container"
require_relative "lib/containers/scouting_container"
require_relative "lib/containers/autonomous_container"
require_relative "lib/containers/teleop_container"
require_relative "lib/containers/scout_team_container"
require_relative "lib/containers/about_container"

require_relative "lib/ui/window"

Window.new.show
