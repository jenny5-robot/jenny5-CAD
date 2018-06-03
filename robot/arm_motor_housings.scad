// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

use <../basic_scad/stepper_motors_housing.scad>
include <../basic_scad/params_motor_housing.scad>
include <params_arm.scad>
include <../basic_scad/params_stepper_motor_gearbox.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
include <../basic_scad/params_basic_components.scad>
use <../basic_scad/radial_bearings.scad>
use <../basic_scad/belt_tensioner.scad>



//---------------------------------------------------------------------------
module shoulder_motor_housing()
{
      nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset = 4, belt_tensioner_offset = 20, nema_width = 43, nema_height = nema_17_height, base_height = 40, nema_center_hole_radius = 5, nema_holes_position = nema17_gearbox_tensioner_sheet_screw_hole_position, base_thick = wall_thick_base_motor_housing, dist_to_base_holes_center_z = 18, nema_housing_base_holes_H_distance = 28, nema_housing_base_holes_V_distance = 35, sunken_base_holes = 1, belt_tensioner_distance_between_holes = belt_tensioner_distance_between_holes, motor_play_x = 10);
}
//---------------------------------------------------------------------------
module shoulder_motor_housing_with_belt_tensioner()
{
    shoulder_motor_housing();
// first belt tensioner
    translate ([washer_4_12_external_radius + wall_thick_base_motor_housing + 10, nema_17_housing_width / 2 - belt_tensioner_distance_between_holes / 2, 0]){
    // screws
        translate ([0, 0, wall_thick_base_motor_housing + m4_nut_thick + 1]) mirror([0, 0, 1]) M4_hexa(25);
    // bearings
       translate ([0, 0, -bearing_4_height - 1]) 624rs(); 
       translate ([0, 0, -2 * bearing_4_height - 1]) 624rs(); 
       translate ([0, 0, -3 * bearing_4_height - 1]) 624rs(); 
    }
// second belt tensioner
    translate ([washer_4_12_external_radius + wall_thick_base_motor_housing + 10, nema_17_housing_width / 2 + belt_tensioner_distance_between_holes / 2, 0]){
    // screws
        translate ([0, 0, wall_thick_base_motor_housing + m4_nut_thick + 1]) mirror([0, 0, 1]) M4_hexa(25);
    // bearings
       translate ([0, 0, -bearing_4_height - 1]) 624rs(); 
       translate ([0, 0, -2 * bearing_4_height - 1]) 624rs(); 
       translate ([0, 0, -3 * bearing_4_height - 1]) 624rs(); 
    }
    
    translate ([washer_4_12_external_radius + wall_thick_base_motor_housing + 10, nema_17_housing_width / 2, -16]) mirror([0, 0, 1]) rotate ([0, 0, 90]) belt_tensioner_spacer(belt_tensioner_distance_between_holes);
}
//---------------------------------------------------------------------------

module forearm_motor_housing()
{
    nema_motor_housing_with_base_holes(motor_offset_x = 10, motor_offset_y = 0, nema_width = belt_hole_forearm_pulley, nema_height = nema_11_height, base_height = 20, nema_center_hole_radius = 5.5, nema_holes_position = gearbox_nema_11_holes_position, base_thick = 3, dist_to_base_holes_center_z = 14, nema_housing_base_holes_H_distance = undef, nema_housing_base_holes_V_distance = undef, motor_screw_holes_rotation_angle = 45, sunken_base_holes = 0, motor_play_x = 0);
    
 /*
    nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset = 10, belt_tensioner_offset = 12, nema_width = belt_hole_forearm_pulley, nema_height = nema_11_height, base_height = 20, nema_center_hole_radius = 5, nema_holes_position = nema11_gearbox_tensioner_sheet_screw_hole_position, base_thick = 3, dist_to_base_holes_center_z = 14, nema_housing_base_holes_H_distance = undef, nema_housing_base_holes_V_distance = undef, motor_screw_holes_rotation_angle = 0, belt_tensioner_distance_between_holes = 30);
    */
}
//---------------------------------------------------------------------------
module upper_arm_motor_housing()
{
    nema_motor_housing_with_base_holes(0, 0, nema_17_width, nema_17_height, 40, nema_17_gearbox_motor_hole_radius, gearbox_nema_17_holes_position, 3, 13, nema_17_housing_small_base_holes_position);    
}
//---------------------------------------------------------------------------
module body_stepper_motor_housing()
{
      nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset = 4, belt_tensioner_offset = 20, nema_width = 41, nema_height = nema_17_height, base_height = 40, nema_center_hole_radius = 5, nema_holes_position = nema17_gearbox_tensioner_sheet_screw_hole_position, base_thick = wall_thick_base_motor_housing, dist_to_base_holes_center_z = 18, nema_housing_base_holes_H_distance = 28, nema_housing_base_holes_V_distance = 33, sunken_base_holes = 1, belt_tensioner_distance_between_holes = belt_tensioner_distance_between_holes, motor_play_x = 10);
}
//---------------------------------------------------------------------------
module body_stepper_motor_housing_with_belt_tensioner()
{
    body_stepper_motor_housing();
// first belt tensioner
    translate ([washer_4_12_external_radius + wall_thick_base_motor_housing + 10, nema_17_housing_width / 2 - belt_tensioner_distance_between_holes / 2, 0]){
    // screws
        translate ([0, 0, wall_thick_base_motor_housing + m4_nut_thick + 1]) mirror([0, 0, 1]) M4_hexa(25);
    // bearings
       translate ([0, 0, -bearing_4_height - 1]) 624rs(); 
       translate ([0, 0, -2 * bearing_4_height - 1]) 624rs(); 
       translate ([0, 0, -3 * bearing_4_height - 1]) 624rs(); 
    }
// second belt tensioner
    translate ([washer_4_12_external_radius + wall_thick_base_motor_housing + 10, nema_17_housing_width / 2 + belt_tensioner_distance_between_holes / 2, 0]){
    // screws
        translate ([0, 0, wall_thick_base_motor_housing + m4_nut_thick + 1]) mirror([0, 0, 1]) M4_hexa(25);
    // bearings
       translate ([0, 0, -bearing_4_height - 1]) 624rs(); 
       translate ([0, 0, -2 * bearing_4_height - 1]) 624rs(); 
       translate ([0, 0, -3 * bearing_4_height - 1]) 624rs(); 
    }
    
    translate ([washer_4_12_external_radius + wall_thick_base_motor_housing + 10, nema_17_housing_width / 2, -16]) mirror([0, 0, 1]) rotate ([0, 0, 90]) belt_tensioner_spacer(belt_tensioner_distance_between_holes);
    
}
//---------------------------------------------------------------------------


shoulder_motor_housing();