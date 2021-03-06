# The Nature of Code
# NOC_6_01_Seek

load_library :vecmath

class Vehicle
  attr_reader :location, :velocity, :acceleration
  def initialize(x, y)
    @acceleration = Vec2D.new
    @velocity = Vec2D.new(0, -2)
    @location = Vec2D.new(x, y)
    @r = 6
    @maxspeed = 4
    @maxforce = 0.1
  end

  def apply_force(force)
    @acceleration += force
  end

  def update
    @velocity += acceleration
    @velocity.set_mag(@maxspeed) { velocity.mag > @maxspeed }
    @location += velocity
    @acceleration *= 0
  end

  def seek(target)
    desired = target - location
    return if desired.mag < PConstants.EPSILON
    desired.normalize!
    desired *= @maxspeed
    steer = desired - velocity
    steer.set_mag(@maxforce) { steer.mag > @maxforce }
    apply_force(steer)
  end

  def display
    theta = velocity.heading + PI / 2
    fill(127)
    stroke(0)
    stroke_weight(1)
    push_matrix
    translate(location.x, location.y)
    rotate(theta)
    begin_shape
    vertex(0, -@r * 2)
    vertex(-@r, @r * 2)
    vertex(@r, @r * 2)
    end_shape(CLOSE)
    pop_matrix
  end
end

attr_reader :seeker

def setup
  size(640, 360)
  @seeker = Vehicle.new(width / 2, height / 2)
end

def draw
  background(255)
  mouse = Vec2D.new(mouse_x, mouse_y)
  fill(200)
  stroke(0)
  stroke_weight(2)
  ellipse(mouse.x, mouse.y, 48, 48)
  # Call the appropriate steering behaviors for our agents
  seeker.seek(mouse)
  seeker.update
  seeker.display
end
