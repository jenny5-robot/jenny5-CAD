// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_thrust_bearings.scad>
include <params_basic_components.scad>
include <material_colors.scad>
include <tolerance.scad>

//--------------------------------------------------------------
module thrust_bearing(external_radius, internal_radius, height)
{
    difference(){
        color(steel_color)
        cylinder(h = height, r = external_radius, $fn = 100);
        translate (-display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = internal_radius, $fn = 100);
    }
}
//--------------------------------------------------------------
module thrust_bearing_51105()
{
    thrust_bearing(external_radius = tb_51105_external_radius, internal_radius = tb_51105_internal_radius, height = tb_51105_height);
}
//--------------------------------------------------------------

thrust_bearing_51105();