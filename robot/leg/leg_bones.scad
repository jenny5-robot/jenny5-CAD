// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

use <../../basic_scad/basic_components.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>
use <../../basic_scad/screws_nuts_washers.scad>
include <../../basic_scad/params_radial_bearings.scad>
use <../../basic_scad/radial_bearings.scad>
use <../../basic_scad/radial_bearing_housing.scad>
use <../../basic_scad/radial_bearing_u_housing.scad>
include <../../basic_scad/config.scad>

include <leg_params.scad>

include <../../basic_scad/tolerance.scad>

use <leg_sheets.scad>
//---------------------------------------------------------
module leg_bone()
{
    //render(){
    
        difference(){
          //  translate ([-leg_bone_thick[0] / 2, -leg_bone_thick[1] / 2, 0])
            color(aluminium_color) rectangular_tube (leg_bone_thick[0], leg_bone_thick[1], 2, leg_bone_length);
            // shaft hole
            echo("middle hole", rbearing_6001_housing_holes_position[0] + [ rbearing_6001_housing_size_thicker[0] / 2, leg_bone_thick[0] / 2, 0], "radius = 12.5");
            translate ([0, leg_bone_thick[1] / 2, rbearing_6001_housing_size_thicker[0] / 2])
                rotate([90, 0, 0]) {
                    translate (rbearing_6001_housing_holes_position[0] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = 12.5, $fn = 70);
        // screws holes
                    echo("screw hole");
                    for (i = [1 : 4]){
                        translate (rbearing_6001_housing_holes_position[i] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
                    echo(rbearing_6001_housing_holes_position[i] + [ rbearing_6001_housing_size_thicker[0] / 2, leg_bone_thick[0] / 2, 0], "radius = 2");
                    }
                }
            // holes in the other side
            translate ([0, leg_bone_thick[1] / 2, leg_bone_length - rbearing_6001_housing_size_thicker[0] / 2])
                rotate([90, 0, 0]) {
                    translate (rbearing_6001_housing_holes_position[0] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = 12.5, $fn = 70);
        // screws holes
                    for (i = [1 : 4])
                        translate (rbearing_6001_housing_holes_position[i] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = 1.6, $fn = 20);
                }
                
        }
}
//----------------------------------------------------------------------
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
    leg_bone_with_bearings();
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