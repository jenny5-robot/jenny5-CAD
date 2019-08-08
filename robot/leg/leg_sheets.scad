// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT
//--------------------------------------------------------------

include <../../basic_scad/params_basic_components.scad>
use <../../basic_scad/basic_components.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>
use <../../basic_scad/screws_nuts_washers.scad>
include <../../basic_scad/params_radial_bearings.scad>
use <../../basic_scad/radial_bearings.scad>
use <../../basic_scad/radial_bearing_housing.scad>
include <../../basic_scad/material_colors.scad>

include <leg_params.scad>

use <../../basic_scad/alu_profiles.scad>

include <../../basic_scad/tolerance.scad>

//-------------------------------------------------------
module leg_base_side(base_height = 40)
{
    color (aluminium_color) 
    render()
    difference(){
        echo("leg base size = ", lateral_top_base_size[0], lateral_top_base_size[1], base_height);
        cube([lateral_top_base_size[0], lateral_top_base_size[1], base_height]);
        
     // hole first bone
        echo("first bone hole position = ", leg_distance_to_first_bone, base_height - leg_shaft_distance_to_edge);
        translate ([leg_distance_to_first_bone, 0, base_height - leg_shaft_distance_to_edge] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M12_screw_radius, $fn = 30);
        
     // hole second bone
        echo("second bone hole position = ", leg_distance_to_second_bone, base_height - leg_shaft_distance_to_edge);
        translate ([leg_distance_to_second_bone, 0, base_height - leg_shaft_distance_to_edge] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M12_screw_radius, $fn = 30);
                
     // hole motor shaft
        echo("motor support hole position = ", leg_distance_to_push_motor_hole_in_base, leg_distance_to_motor_shaft_in_base);
        translate ([leg_distance_to_push_motor_hole_in_base, 0, leg_distance_to_motor_shaft_in_base] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M8_screw_radius, $fn = 30);
        // spacer hole 1
        echo("spacer hole 1", leg_distance_to_first_spacer);
        translate ([leg_distance_to_first_spacer, 0, 15] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M8_screw_radius, $fn = 30);
        // spacer hole 2
        echo("spacer hole 2", leg_distance_to_second_spacer);
        translate ([leg_distance_to_second_spacer, 0, 15] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M8_screw_radius, $fn = 30);
        
    }
}
//-------------------------------------------------------
module knee_side()
{
    difference(){
        // sheet
        echo("knee size", knee_side_simple_sizes);
        color (aluminium_color) cube(knee_side_simple_sizes);
        // front hole bottom
        echo("knee side holes = ");
        echo([leg_shaft_distance_to_edge, 0, leg_shaft_distance_to_edge], "radius = 6");
        translate ([leg_shaft_distance_to_edge, 0, leg_shaft_distance_to_edge] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M12_screw_radius, $fn = 30);
        // back hole bottom
        echo([knee_side_simple_sizes[0] - leg_shaft_distance_to_edge, 0, leg_shaft_distance_to_edge], "radius = 6");
        translate ([knee_side_simple_sizes[0] - leg_shaft_distance_to_edge, 0, leg_shaft_distance_to_edge] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M12_screw_radius, $fn = 30);
        // middle hole for spacer
        echo([knee_side_simple_sizes[0] / 2, 0, knee_side_simple_sizes[2] - 15], "radius = 4");
        translate([knee_side_simple_sizes[0] / 2, 0, knee_side_simple_sizes[2] - 15] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = knee_side_simple_sizes[1] + 2 * display_tolerance, r = M8_screw_radius);
    }
}
//-------------------------------------------------------

module leg_pusher_bearing_sheet()
{
    // to be designed
}
//-------------------------------------------------------

//leg_base_side();

knee_side();