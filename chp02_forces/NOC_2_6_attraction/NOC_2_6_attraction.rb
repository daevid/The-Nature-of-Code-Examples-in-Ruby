#  NOC_2_6_attraction
# The Nature of Code
# http://natureofcode.com
# A class for a draggable attractive body in our world

load_library :vecmath
require_relative 'attractor'
require_relative 'mover'

attr_reader :attractor, :mover

def setup
  size(640, 360)
  @mover =  Mover.new
  @attractor = Attractor.new(width, height)
end

def draw
  background(255)
  force = attractor.attract(mover)
  mover.apply_force(force)
  mover.update
  attractor.drag
  attractor.hover(mouse_x, mouse_y)
  attractor.display
  mover.display
end

def mouse_pressed
  attractor.clicked(mouse_x, mouse_y)
end

def mouse_released
  attractor.stop_dragging
end
