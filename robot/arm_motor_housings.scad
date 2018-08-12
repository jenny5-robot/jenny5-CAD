// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// Jenny5 details: jenny5.org, https://jenny5-robot.github.io/
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
include <params_arm.scad>
include <../basic_scad/as5147_params.scad>
use <../basic_scad/as5147.scad>

include <../basic_scad/tolerance.scad>

//---------------------------------------------------------------------------
module shoulder_left_right_motor_housing()
{
      nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset = shoulder_left_right_motor_offset, belt_tensioner_offset = shoulder_left_right_belt_tensioner_offset, nema_width = 43, motor_housing_interior_width =  43, nema_height = nema_17_height, base_height = 40, nema_center_hole_radius = 5, nema_holes_position = nema17_gearbox_tensioner_sheet_screw_hole_position, base_thick = wall_thick_base_motor_housing, dist_to_base_holes_center_z = 18, nema_housing_base_holes_H_distance = 28, nema_housing_base_holes_V_distance = 35, sunken_base_holes = 1, belt_tensioner_distance_between_holes = belt_tensioner_distance_between_holes, motor_play_x = 10);
}
//---------------------------------------------------------------------------
module shoulder_left_right_motor_housing_with_belt_tensioner()
{
    shoulder_left_right_motor_housing();
// first belt tensioner
    translate ([shoulder_left_right_belt_tensioner_offset, nema_17_housing_width / 2 - belt_tensioner_distance_between_holes / 2, 0]){
    // screws
        translate ([0, 0, wall_thick_base_motor_housing + m4_nut_thick + 1]) mirror([0, 0, 1]) M4_hexa(25);
    // bearings
      translate ([0, 0, -bearing_4_height - 2]) 624rs(); 
       translate ([0, 0, -2 * bearing_4_height - 2]) 624rs(); 
       translate ([0, 0, -3 * bearing_4_height - 2]) 624rs(); 
    }
// second belt tensioner
    translate ([shoulder_left_right_belt_tensioner_offset, nema_17_housing_width / 2 + belt_tensioner_distance_between_holes / 2, 0]){
    // screws
        translate ([0, 0, wall_thick_base_motor_housing + m4_nut_thick + 1]) mirror([0, 0, 1]) M4_hexa(25);
    // bearings
       translate ([0, 0, -bearing_4_height - 2]) 624rs(); 
       translate ([0, 0, -2 * bearing_4_height - 2]) 624rs(); 
       translate ([0, 0, -3 * bearing_4_height - 2]) 624rs(); 
    }
    // belt tensioner cover
    translate ([shoulder_left_right_belt_tensioner_offset, nema_17_housing_width / 2, -3 * bearing_4_height - 4]) mirror([0, 0, 1]) rotate ([0, 0, 90]) belt_tensioner_spacer(belt_tensioner_distance_between_holes);
}
//---------------------------------------------------------------------------

module fore_arm_motor_housing()
{
    nema_motor_housing_with_base_holes(motor_offset_x = fore_arm_motor_offset, motor_offset_y = 0, nema_width = nema_11_width, motor_housing_interior_width = belt_hole_fore_arm_pulley_length, nema_height = nema_11_height, base_height = 20, nema_center_hole_radius = 5.5, nema_holes_position = gearbox_nema_11_holes_position, base_thick = 3, dist_to_base_holes_center_z = 14, nema_housing_base_holes_H_distance = undef, nema_housing_base_holes_V_distance = undef, motor_screw_holes_rotation_angle = 45, sunken_base_holes = 0, motor_play_x = 0);
}
//---------------------------------------------------------------------------
module upper_arm_motor_housing()
{
    nema_motor_housing_with_base_holes(0, 0, nema_17_width, nema_17_width, nema_17_height, 40, nema_17_gearbox_motor_hole_radius, gearbox_nema_17_holes_position, 3, 13, nema_17_housing_small_base_holes_position);    
}
//---------------------------------------------------------------------------
module body_stepper_motor_housing()
{
      nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset = 4, belt_tensioner_offset = body_stepper_motor_housing_belt_tensioner_offset, nema_width = 41, motor_housing_interior_width = body_motor_housing_interior_width, nema_height = nema_17_height, base_height = 40, nema_center_hole_radius = 5, nema_holes_position = nema17_gearbox_tensioner_sheet_screw_hole_position, base_thick = wall_thick_base_motor_housing, dist_to_base_holes_center_z = 18, nema_housing_base_holes_H_distance = 28, nema_housing_base_holes_V_distance = 33, sunken_base_holes = 1, belt_tensioner_distance_between_holes = belt_tensioner_distance_between_holes, motor_play_x = 10);
}
//---------------------------------------------------------------------------
module shoulder_sensor_support()
{
        belt_tensioner_spacer_with_sensor_support(distance_between_screws = belt_tensioner_distance_between_holes, width = body_stepper_motor_housing_belt_tensioner_offset + rb_6905_external_radius + plate_body_size[2] + 6 + as5147_space_between_holes_length / 2 + as5147_distance_hole_from_margin + 1);
}
//---------------------------------------------------------------------------
module belt_tensioner_spacer_with_sensor_support_and_sensor()
{
    // support
    shoulder_sensor_support();
    
    // sensor
    translate ([-as5147_board_size[1] / 2, body_stepper_motor_housing_belt_tensioner_offset + rb_6905_external_radius + plate_body_size[2] + as5147_space_between_holes_length / 2 + 2, 4 + 1]) rotate ([0, 0, -90]) as5147();
}
//---------------------------------------------------------------------------

module body_stepper_motor_housing_with_belt_tensioner()
{
    body_stepper_motor_housing();
// first belt tensioner
    translate ([body_stepper_motor_housing_belt_tensioner_offset, (body_motor_housing_interior_width + 4) / 2 - belt_tensioner_distance_between_holes / 2, 0]){
    // screws
        translate ([0, 0, wall_thick_base_motor_housing + m4_nut_thick + 1]) mirror([0, 0, 1]) M4_hexa(45);
    // bearings
       translate ([0, 0, -bearing_4_height - 1]) 624rs(); 
       translate ([0, 0, -2 * bearing_4_height - 1]) 624rs(); 
       translate ([0, 0, -3 * bearing_4_height - 1]) 624rs(); 
    }
// second belt tensioner
    translate ([body_stepper_motor_housing_belt_tensioner_offset, (body_motor_housing_interior_width + 4) / 2 + belt_tensioner_distance_between_holes / 2, 0]){
    // screws
        translate ([0, 0, wall_thick_base_motor_housing + m4_nut_thick + 1]) mirror([0, 0, 1]) M4_hexa(45);
    // bearings
       translate ([0, 0, -bearing_4_height - 1]) 624rs(); 
       translate ([0, 0, -2 * bearing_4_height - 1]) 624rs(); 
       translate ([0, 0, -3 * bearing_4_height - 1]) 624rs(); 
    }
    
    translate ([body_stepper_motor_housing_belt_tensioner_offset, (body_motor_housing_interior_width + 4) / 2, -16 - 5 - 3 - 10]) rotate ([0, 0, 90]) belt_tensioner_spacer_with_sensor_support_and_sensor();
    
}
//---------------------------------------------------------------------------
module upper_arm_motor_corner()
{   
    difference(){
        nema_motor_housing_with_base_holes(motor_offset_x = elbow_rotation_motor_offset, motor_offset_y = 0, nema_width = rbearing_608_housing_size[0], motor_housing_interior_width = rbearing_608_housing_size[0], nema_height = 20, base_height = 18, nema_center_hole_radius = 10, nema_holes_position = rbearing_608_housing_holes_position, base_thick = 3, dist_to_base_holes_center_z = 18, nema_housing_base_holes_H_distance = undef, nema_housing_base_holes_V_distance = undef, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0, motor_play_x = 0);    
        hull(){
            translate ([3 + 10, 4, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = 2, $fn = 15);
            translate ([3 + 10, 7, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = 2, $fn = 15);
        }
        hull(){
            translate ([3 + 10, rbearing_608_housing_size[0] -0, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = 2, $fn = 15);
            translate ([3 + 10, rbearing_608_housing_size[0] - 3, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = 2, $fn = 15);
        }
    }
}
//---------------------------------------------------------------------------

upper_arm_motor_corner();
//fore_arm_motor_housing();
//shoulder_motor_housing();
//body_stepper_motor_housing_with_belt_tensioner();

//belt_tensioner_spacer_with_sensor_support_and_sensor();

//shoulder_sensor_support();

//shoulder_left_right_motor_housing_with_belt_tensioner();