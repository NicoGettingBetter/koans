# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  # WRITE THIS CODE
  raise TriangleError.new unless is_triangle?(a, b, c)
  return :equilateral if equilateral(a, b, c)
  return :isosceles if isosceles(a, b, c)
  :scalene
end

def is_triangle?(a, b, c)
	less_zero = -> x { x <= 0 }
	one_more_than_sum = -> (x, y, z) { x + y <= z }
	return false if (less_zero.(a) || less_zero.(b) || less_zero.(c) ||
		one_more_than_sum.(a, b, c) ||
		one_more_than_sum.(a, c, b) ||
		one_more_than_sum.(b, c, a))
	true
end

def equilateral(a, b, c)
	a == b.to_i && a.to_i == c.to_i
end

def isosceles(a, b, c)
	a.to_i == b.to_i || a.to_i == c.to_i || b.to_i == c.to_i
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
