# NOC_3_01_angular_motion
# The Nature of Code
# http://natureofcode.com
def setup
  size(800, 200)
  smooth
  @angle = 0
  @velocity = 0
  @acceleration = 0.0001
end

def draw
  background(255)

  fill(127)
  stroke(0)

  translate(width/2, height/2)
  rect_mode(CENTER)
  rotate(@angle)
  stroke(0)
  stroke_weight(2)
  fill(127)
  line(-60, 0, 60, 0)
  ellipse(60, 0, 16, 16)
  ellipse(-60, 0, 16, 16)

  @angle += @velocity
  @velocity += @acceleration
end
