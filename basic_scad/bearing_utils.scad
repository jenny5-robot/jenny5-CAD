// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <tolerance.scad>

//--------------------------------------------------------------
module bush_bearing_bone(radial_bearing_radius = 7.5, bone_edge = 10, height = 9)
{
    difference(){
        cylinder(h = height, r = radial_bearing_radius, $fn = 50);
        translate ([-bone_edge / 2, -bone_edge / 2, 0] - display_tolerance_z) cube ([bone_edge, bone_edge, height] + 2 * display_tolerance_z);
    }
}
//--------------------------------------------------------------
bush_bearing_bone();