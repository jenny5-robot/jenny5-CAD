// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


include <arm_params.scad>

use <../../basic_scad/basic_components.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>
use <../../basic_scad/screws_nuts_washers.scad>
include <../../basic_scad/material_colors.scad>

include <../../basic_scad/tolerance.scad>

use <arm_sheets.scad>

use <arm_sensor_support.scad>
include <arm_sensor_support_params.scad>

//---------------------------------------------------------------------------
module fore_arm_bone()
{
    color (aluminium_color) 
    difference(){
        rectangular_tube(length = arm_shaft_size, width = arm_shaft_size, wall_thick = 2, height = fore_arm_length);
        // top gear shaft hole
        translate([0, - arm_shaft_size / 2, fore_arm_length - 8] - display_tolerance_y) rotate([90, 0, 0]) cylinder(h = arm_shaft_size + 2 * display_tolerance, r = 4);
        // top pulley hole 
        translate ([- arm_shaft_size / 2, -8.5, fore_arm_length - 80] - display_tolerance_x) cube([arm_shaft_size, 17, 80] + 2 * display_tolerance_xz);
    }
}
//---------------------------------------------------------------------------
module upper_arm_bone()
{
    color (aluminium_color) 
    difference(){
        rectangular_tube(length = arm_shaft_size, width = arm_shaft_size, wall_thick = 2, height = upper_arm_bone_length);
        // top gear shaft hole
        translate([0, - arm_shaft_size / 2, upper_arm_bone_length - 8] - display_tolerance_y) rotate([90, 0, 0]) cylinder(h = arm_shaft_size + 2 * display_tolerance, r = 4);
        // top pulley hole 
        translate ([- arm_shaft_size / 2, -8.5, upper_arm_bone_length - 80] - display_tolerance_x) cube([arm_shaft_size, 17, 80] + 2 * display_tolerance_xz);
        // screw hole for wrist pulley
        translate([0, arm_shaft_size / 2, upper_arm_bone_length - 8] + display_tolerance_y) rotate([90, 0, 0]) cylinder(h = arm_shaft_size + 2 * display_tolerance, r = 4);
        // screws for sensor support
        echo(as5147_space_between_holes_length / 2 + as5147_distance_hole_from_margin + 1 -8 -(as5147_board_size[0] + 8 + 8) - 4.5);
        echo(as5147_space_between_holes_length / 2 + as5147_distance_hole_from_margin + 1 -8 -(as5147_board_size[0] + 8 + 8) + 4.5);
        translate([0, arm_shaft_size / 2, upper_arm_bone_length + as5147_space_between_holes_length / 2 + as5147_distance_hole_from_margin + 1 -8 -(as5147_board_size[0] + 8 + 8) - 4.5] + display_tolerance_y) rotate([90, 0, 0]) cylinder(h = arm_shaft_size + 2 * display_tolerance, r = 1.5);
        
        translate([0, arm_shaft_size / 2, upper_arm_bone_length + as5147_space_between_holes_length / 2 + as5147_distance_hole_from_margin + 1 -8 -(as5147_board_size[0] + 8 + 8) + 4.5] + display_tolerance_y) rotate([90, 0, 0]) cylinder(h = arm_shaft_size + 2 * display_tolerance, r = 1.5);        
                
    }
}
//---------------------------------------------------------------------------
module shoulder_up_down_bone()
{
     color (aluminium_color) 
            rectangular_tube(length = arm_shaft_size, width = arm_shaft_size, wall_thick = 2, height = upper_arm_shaft_support_length);
}
//---------------------------------------------------------------------------
upper_arm_bone();