HOME_HEADER_COLOR       = 0xff_008800#Gosu::Color.rgb(0, 200, 0)
SCOUTING_HEADER_COLOR   = Gosu::Color.rgb(40, 40, 40)
AUTONOMOUS_HEADER_COLOR = Gosu::Color.rgb(100, 0, 0)
TELEOP_HEADER_COLOR     = Gosu::Color.rgb(0, 0, 50)
BODY_COLOR   = Gosu::Color.rgb(200, 200, 200)#Gosu::Color.rgb(12,12,12)

class Window < Gosu::Window
  NAME = "TimeCrafters Analytical Engine"
  attr_reader :elements, :mouse

  def self.instance=(this)
    @instance = this
  end

  def self.instance
    @instance
  end

  def initialize
    Window.instance = self
    super(1000, 700, false)
    $window = self
    self.caption = NAME
    AppSync.teams_list="./data/galaxy_teams_list.txt"

    @elements = []
    @header_color = HOME_HEADER_COLOR
    @mouse = Mouse.new(0, 0)
    @active_container = MainContainer.new

    @title = Text.new(NAME, true, size: 36, y: 20)
    @current_team = Text.new("Team: 0000 | TEAMNAME", true, size: 20, x: 420, y: 70, color: Gosu::Color::YELLOW)
    Button.new("Home", 10, 60) { @header_color = HOME_HEADER_COLOR; @active_container = MainContainer.new }
    Button.new("Scouting", 90, 60) { @header_color = SCOUTING_HEADER_COLOR; @active_container = ScoutingContainer.new }
    Button.new("Autonomous", 195, 60) { @header_color = AUTONOMOUS_HEADER_COLOR; @active_container = AutonomousContainer.new }
    Button.new("TeleOp", 330, 60) { @header_color = TELEOP_HEADER_COLOR; @active_container = TeleOpContainer.new }

    Button.new("Refresh", 905, 60)
  end

  def draw
    fill_rect(0, 0, self.width, 100, @header_color)
    fill_rect(0, 100, self.width, self.height, BODY_COLOR)
    @elements.each(&:draw)
    if @active_container.is_a?(Container)
      @active_container.draw
    end
  end

  def update
    @mouse.x, @mouse.y = self.mouse_x, self.mouse_y
    @title.x = (Gosu.screen_width/4)-(@title.textobject.text_width(NAME)/2)

    if AppSync.team_number
      @current_team.text = "Team: #{AppSync.team_number} | #{AppSync.team_name}"
      @current_team.color= Gosu::Color::WHITE
    else
      @current_team.text = "Team: no team selected."
      @current_team.color= Gosu::Color::YELLOW
    end

    @elements.each(&:update)
    if @active_container.is_a?(Container)
      @active_container.update
    end
  end

  def button_up(id)
    @elements.each {|e| if defined?(e.button_up); e.button_up(id); end}
    if @active_container.is_a?(Container)
      @active_container.button_up(id)
    end
  end

  def needs_cursor?
    true
  end

  def fill_rect(x, y, width, height, color = Gosu::Color::WHITE, z = 0, mode = :default)
    return  draw_quad(x, y, color,
                      x, height+y, color,
                      width+x, height+y, color,
                      width+x, y, color,
                      z, mode)
  end
end
