// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_chair_wheel.scad>
use <basic_components.scad>

module chair_wheel()
{
  color ("black") rotate([0, 90, 0]) cylinder(h = chair_wheel_thick, r = chair_wheel_radius, $fn = 50);
  translate ([25, -10, chair_wheel_height - chair_wheel_radius + 5]) mirror ([0, 0, 1]) rotate ([0, 0, 90]) U(20, 30, chair_wheel_height - chair_wheel_radius + 10, 3);
}


chair_wheel();