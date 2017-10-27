HOME_HEADER_COLOR       = Gosu::Color.rgb(0, 128, 0)
SCOUTING_HEADER_COLOR   = Gosu::Color.rgb(40, 40, 40)
AUTONOMOUS_HEADER_COLOR = Gosu::Color.rgb(100, 0, 0)
TELEOP_HEADER_COLOR     = Gosu::Color.rgb(0, 0, 70)
ABOUT_HEADER_COLOR      = Gosu::Color.rgb(200, 80, 0)
BODY_COLOR   = Gosu::Color.rgb(175, 175, 175)#Gosu::Color.rgb(12,12,12)

class Window < Gosu::Window
  NAME = "TimeCrafters Analytical Engine Companion"
  attr_accessor :active_container
  attr_reader :elements, :mouse

  def self.instance=(this)
    @instance = this
  end

  def self.instance
    @instance
  end

  def initialize
    Window.instance = self
    if Gosu.screen_width < 1300
      super(1280, 720, false)
    else
      super((Gosu.screen_width/4)*3, (Gosu.screen_height/4)*3, false)
    end
    $window = self
    self.caption = NAME
    list_search_results = []
    Dir.glob("#{Dir.pwd}/data/*.txt").each {|f| if f.include?("list"); list_search_results << f; end}
    AppSync.teams_list=list_search_results.first if list_search_results.first

    @elements = []
    @header_color = HOME_HEADER_COLOR
    @mouse = Mouse.new(0, 0)
    @active_container = MainContainer.new

    @title = Text.new(NAME, true, size: 36, x: BUTTON_PADDING, y: 20, font: "Sans Serif", shadow: true)

    _b = Button.new("Home", 10, 60, true, "Home is where team selection happens") { @header_color = HOME_HEADER_COLOR; @active_container = MainContainer.new }
    b  = Button.new("Scouting", BUTTON_PADDING+_b.x+_b.width, 60, true, "Scouting data for selected team") { @header_color = SCOUTING_HEADER_COLOR; @active_container = ScoutingContainer.new }
    _b = Button.new("Autonomous", BUTTON_PADDING+b.x+b.width, 60, true, "Autonomous match data for selected team") { @header_color = AUTONOMOUS_HEADER_COLOR; @active_container = AutonomousContainer.new }
    b  = Button.new("TeleOp", BUTTON_PADDING+_b.x+_b.width, 60, true, "TeleOp match data for selected team") { @header_color = TELEOP_HEADER_COLOR; @active_container = TeleOpContainer.new }

    if ARGV.join.include?("--debug")
      _b = Button.new("Scout", BUTTON_PADDING+b.x+b.width+50, 60, true, "Scout a team") { @header_color = TELEOP_HEADER_COLOR; @active_container = ScoutTeamContainer.new }
      b  = Button.new("Track", BUTTON_PADDING+_b.x+_b.width, 60, true, "Track a match") {}
    end

    @current_team = Text.new("Team: 0000 | TEAMNAME", true, size: 24, x: BUTTON_PADDING+b.x+b.width, y: 68, color: Gosu::Color.rgb(0,45,15))

    b = Button.new("About", 0, 60, true, "About the #{NAME}") { @header_color = ABOUT_HEADER_COLOR; @active_container = AboutContainer.new }
    b.x = $window.width-(b.width+10)
    b.update_position_toolip
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

    if AppSync.team_name.length > 0
      @current_team.text = "Team: #{AppSync.team_number} | #{AppSync.team_name}"
      @current_team.color= Gosu::Color::WHITE
    else
      @current_team.text = "Team: no team selected."
      @current_team.color= Gosu::Color.rgb(200, 200, 200)
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

    if id == Gosu::KbF11
      if fullscreen?
        if Gosu.screen_width < 1300
          resize(1280, 720, false)
        else
          resize((Gosu.screen_width/4)*3, (Gosu.screen_height/4)*3, false)
        end
      else
        resize(Gosu.screen_width, Gosu.screen_height, true)
      end
    end
  end

  def resize(width, height, fullscreen)
    self.width = width
    self.height= height
    self.fullscreen = fullscreen
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
