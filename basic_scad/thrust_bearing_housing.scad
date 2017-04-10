// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_thrust_bearing_housing.scad>
include <params_thrust_bearings.scad>
include <params_basic_components.scad>
include <config.scad>

//--------------------------------------------------
module thrust_bearing_housing(housing_size, bearing_external_radius, bearing_internal_radius)
{
    translate ([-housing_size[0] / 2, -housing_size[1] / 2, 0])
    difference(){
        color (plastic_color)
        cube(housing_size);
        
        // bearing
        translate([housing_size[0] / 2, housing_size[1] / 2, housing_size[2] - thrust_bearing_depth])
            difference(){
                cylinder(h = thrust_bearing_depth + 1, r = bearing_external_radius, $fn = 100);
                translate (-display_tolerance_z) cylinder(h = thrust_bearing_depth + 1 + 2 * display_tolerance, r = bearing_internal_radius, $fn = 100);
            }
        // central shaft
        translate ([housing_size[0] / 2, housing_size[1] / 2, 0] -display_tolerance_z) cylinder(h = housing_size[2] + 2 * display_tolerance, r = 5, $fn = 100);
            
            // screw holes
            for (i = [0 : 3])
        translate(thrust_bearing_housing_51105_holes[i] - display_tolerance_z) cylinder (h = housing_size[2] + 2 * display_tolerance, r = 2, $fn = 20);
    }
}
//--------------------------------------------------
module thrust_bearing_housing_51105()
{
    thrust_bearing_housing(thrust_bearing_housing_51105_size, tb_51105_external_radius, tb_51105_internal_radius);
}
//--------------------------------------------------

thrust_bearing_housing_51105();