// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT
//--------------------------------------------------------------

use <leg_bones.scad>
use <../../basic_scad/radial_bearings.scad>
use <../../basic_scad/radial_bearing_housing.scad>
use <../../basic_scad/radial_bearing_u_housing.scad>

include <../../basic_scad/tolerance.scad>
include <../../basic_scad/params_radial_bearings_u_housing.scad>


include <leg_params.scad>

//--------------------------------------------------------------
module leg_bone_with_bearings()
{
        leg_bone();
 
    // bottom bearing
    // plastic housing
    translate([0, rb_6001_thick, rbearing_6001_housing_size_thicker[0] / 2]) rotate ([90, 0, 0]) rbearing_6001_double_housing_thicker_wall(0);
    // one bearing
    translate([0, 0, rbearing_6001_housing_size_thicker[0] / 2]) rotate ([90, 0, 0]) 6001rs();
    // the other bearing
    translate([0, rb_6001_thick, rbearing_6001_housing_size_thicker[0] / 2]) rotate ([90, 0, 0]) 6001rs();
    
    translate([0, 0, leg_bone_length - rbearing_6001_housing_size_thicker[0]]){
    // top bearing
    // plastic housing
        translate([0, rb_6001_thick, rbearing_6001_housing_size_thicker[0] / 2]) rotate ([90, 0, 0]) rbearing_6001_double_housing_thicker_wall(0);
    // one bearing
        translate([0, 0, rbearing_6001_housing_size_thicker[0] / 2]) rotate ([90, 0, 0]) 6001rs();
    // the other bearing
        translate([0, rb_6001_thick, rbearing_6001_housing_size_thicker[0] / 2]) rotate ([90, 0, 0]) 6001rs();
    }
}
//----------------------------------------------------------------------
module front_bone_with_pusher_components()
{
    difference(){
        leg_bone_with_bearings();
        translate ([-leg_bone_thick[0] / 2, 0, leg_distance_to_pusher - rbearing_6905_enclosed_housing_holes_position[0][0]] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = leg_bone_thick[0] + 2 * display_tolerance, r = 2);
        translate ([-leg_bone_thick[0] / 2, 0, leg_distance_to_pusher + rbearing_6905_enclosed_housing_holes_position[0][0]] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = leg_bone_thick[0] + 2 * display_tolerance, r = 2);
        echo("front bone pusher support hole 1 = ", leg_distance_to_pusher - (rbearing_6905_enclosed_housing_holes_position[0][0]));
        echo("front bone pusher support hole 2 = ", leg_distance_to_pusher + (rbearing_6905_enclosed_housing_holes_position[0][0]));
    }
    translate([leg_bone_thick[0] / 2 + rb_6905_external_radius, 0, leg_distance_to_pusher]){
            // bearing housing
            translate ([rb_6905_external_radius + radial_bearing_vertical_housing_base_wall_thick, 0, 0]) rotate ([0, -90, 0]) radial_bearing_6905_vertical_housing();
            // bearing 
            rotate([90, 0, 0]) translate ([0, 0, -rb_6905_thick / 2]) 6905rs();
    }
}
//----------------------------------------------------------------------
front_bone_with_pusher_components();

//radial_bearing_6905_vertical_housing();

//rbearing_6001_double_housing_thicker_wall(-1);

//radial_bearing_6905_vertical_housing();