
// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_thrust_bearings.scad>
include <params_basic_components.scad>

//--------------------------------------------------------------
module thrust_bearing(external_radius, internal_radius, height)
{
    difference(){
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