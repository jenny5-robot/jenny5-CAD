// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_chair_wheel.scad>
use <basic_components.scad>

module chair_wheel()
{
// wheel
  color ("black") translate ([-chair_wheel_thick / 2, 0, 0]) rotate([0, 90, 0]) cylinder(h = chair_wheel_thick, r = chair_wheel_radius, $fn = 50);
// U
    color ("gray")
  translate ([chair_wheel_thick - chair_wheel_thick / 2 + 5, -10, chair_wheel_height - chair_wheel_radius + 5]) mirror ([0, 0, 1]) rotate ([0, 0, 90]) U(20, chair_wheel_thick + 10, chair_wheel_height - chair_wheel_radius + 10, 3);
    
 // platform
    color ("gray")
    translate([-chair_wheel_sheet_size[0] / 2, -chair_wheel_sheet_size[1] / 2, chair_wheel_height - chair_wheel_radius + 2]) cube(chair_wheel_sheet_size);
}


chair_wheel();