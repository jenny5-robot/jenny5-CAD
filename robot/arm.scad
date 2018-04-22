// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_arm.scad>

include <../basic_scad/params_basic_components.scad>
use <../basic_scad/basic_components.scad>
use <../basic_scad/stepper_motors.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
use <../basic_scad/stepper_motors_housing.scad>
include <../basic_scad/params_motor_housing.scad>
use <../basic_scad/radial_bearing_housing.scad>
include <../basic_scad/config.scad>
use <../basic_scad/point_transformations_3d.scad>

include <../basic_scad/params_pulleys.scad>
use <../basic_scad/pulleys.scad>
use <../basic_scad/radial_bearings.scad>

include <params_gripper.scad>
use <gripper.scad>
use <../basic_scad/belt.scad>
use <../basic_scad/belt_tensioner.scad>

use <../basic_scad/potentiometer_support.scad>
use <../basic_scad/potentiometers.scad>
include <../basic_scad/params_potentiometers.scad>

include <../basic_scad/params_webcam.scad>

use <../basic_scad/webcam.scad>

use <../basic_scad/tube_bracket.scad>
include <../basic_scad/params_tube_bracket.scad>

use <motor_pulley.scad>
use <arm_pulleys.scad>

use <../basic_scad/stepper_motor_sheets.scad>
include <../basic_scad/params_stepper_motor_gearbox.scad>

include <../basic_scad/tolerance.scad>
include <params_body.scad>

use <arm_sheets.scad>

//---------------------------------------------------------------------------
module upper_arm_motor_housing()
{
    nema_motor_housing_with_base_holes(0, 0, nema_17_width, nema_17_height, 40, nema_17_gearbox_motor_hole_radius, gearbox_nema_17_holes_position, 3, 13, nema_17_housing_small_base_holes_position);    
}
//---------------------------------------------------------------------------
module upper_arm_motor_corners()
{
    nema_motor_housing_with_base_holes(motor_offset_x = 7, motor_offset_y = 0, nema_width = rbearing_608_housing_size[0], nema_height = 30, base_height = 21, nema_center_hole_radius = 5, nema_holes_position = rbearing_608_housing_holes_position, base_thick = 3, dist_to_first_hole_z = 18, nema_housing_base_holes = nema_17_housing_small_base_holes_position, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0, motor_play_x = 0);    
}
//---------------------------------------------------------------------------
module upper_arm_motor_with_components()
{
    nema_17_with_19_1_gearbox();
    
    translate([0, - distance_upper_arm_motor_shaft, 0]) cylinder (h = nema_17_with_19_1_gearbox_height + 20, r = 4); 
    
    // base sheet
    translate ([-sheet_upper_arm_motor_base_size[0] / 2, -sheet_upper_arm_motor_base_size[1] + sheet_upper_arm_motor_base_size[0] / 2, -sheet_upper_arm_motor_base_size[2]]) sheet_upper_arm_motor_base();
    
    // top sheet
    translate ([-sheet_upper_arm_motor_top_size[0] / 2, -sheet_upper_arm_motor_top_size[1] + sheet_upper_arm_motor_top_size[0] / 2, nema_17_with_19_1_gearbox_height]) sheet_upper_arm_motor_base();
    
    //motor pulley
    translate ([0, -distance_upper_arm_motor_shaft, nema_17_with_19_1_gearbox_height + 5])
    pulley(profile = 63, num_teeth = 18, pulley_b_ht = 0, pulley_b_dia = 17, pulley_t_ht = 8);
  
  // shaft pulley at motor 
    translate ([0, 0, nema_17_with_19_1_gearbox_height + 5])
    pulley(profile = 63, num_teeth = 18, pulley_b_ht = 0, pulley_b_dia = 17, pulley_t_ht = 8);

// belt
    rotate ([0, 0, -90])
    translate ([0, 0, nema_17_with_19_1_gearbox_height + 7]) belt_on_2_pulleys(14, 14, distance_upper_arm_motor_shaft, 6);
// belt length    
    //echo (length_belt_on_2_pulleys(r1 = 14, r2 = 14, distance_between_pulleys = distance_upper_arm_motor_shaft));

    translate ([0, -distance_upper_arm_motor_shaft, nema_17_with_19_1_gearbox_height / 2 - 3])
    pulley(profile = 51, num_teeth = 13, pulley_b_ht = 0, pulley_b_dia = 17, pulley_t_ht = 8);
    
    // bearing housing
// base
    translate ([0, -distance_upper_arm_motor_shaft, rbearing_608_housing_size[2]]) mirror([0, 0, 1]) rbearing_608_housing();
    // top
    translate ([0, -distance_upper_arm_motor_shaft, nema_17_with_19_1_gearbox_height - rbearing_608_housing_size[2]]) rbearing_608_housing();
    // bottom corner
    translate ([-16 - 8, -distance_upper_arm_motor_shaft - 16, rbearing_608_housing_size[2]]) upper_arm_motor_corners();
    // top corner
    translate ([-16 - 8, -distance_upper_arm_motor_shaft - 16, -rbearing_608_housing_size[2] + nema_17_with_19_1_gearbox_height]) mirror ([0, 0, 1]) upper_arm_motor_corners();
}
//---------------------------------------------------------------------------
module shoulder_pulley()
{
  pulley_with_shaft(64, 29, 0, 0, 8, 4, m8_nut_radius, m8_nut_thick);
}
//---------------------------------------------------------------------------
module elbow_pulley()
{
  difference(){
      union(){
        pulley(65, 66, 0, 0, 8, 0);
          // motor housing
        translate ([distance_to_fore_arm_gear - 3, -belt_hole_forearm_pulley / 2 - 2, 3]) rotate ([0, 90, 0]) 
          forearm_motor_housing();
          // potentiometer support
        translate ([49, 15, 3]) rotate ([0, 90, 180]) forearm_potentiometer_support();
      }
     
        // bearing hole    
        translate ([0, 0, 0] - display_tolerance_z) cylinder( h = 11 + 2 * display_tolerance, r = rb_626_external_radius, $fn = 50);

        // cut hole for belt
        translate ([distance_to_fore_arm_gear, -belt_hole_forearm_pulley / 2, 0] - display_tolerance_z) cube([15, belt_hole_forearm_pulley, 20]);
        // holes for fixing the forearm
        // first bearing holes
        for (i= [0 : 1]){
            echo([fore_arm_x_offset, 0, 0] + rotate_z(90, rbearing_6905_enclosed_housing_holes_position[i]));
            translate ([fore_arm_x_offset, 0, 0] + rotate_z(90, rbearing_6905_enclosed_housing_holes_position[i]) - display_tolerance_z) cylinder (h = 11 + 2 * display_tolerance, r = 2, $fn = 30);
        }
  }
}
//---------------------------------------------------------------------------
module forearm_motor_housing()
{
  nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset = 0, belt_tensioner_offset = 12, nema_width = belt_hole_forearm_pulley, nema_height = nema_11_height, base_height = 20, nema_center_hole_radius = 5, nema_holes_position = nema11_gearbox_tensioner_sheet_screw_hole_position, base_thick = 3, dist_to_first_hole_z = 14, nema_housing_base_holes = undef, motor_screw_holes_rotation_angle = 0, belt_tensioner_distance_between_holes = 30);
}
//---------------------------------------------------------------------------
module forearm_potentiometer_support()
{
    potentiometer_support_with_screw_holes(30, 30, 10, 29, 8);
}
//---------------------------------------------------------------------------
module elbow_potentiometer_support()
{
    potentiometer_support_on_rectangular_axis(length = 25, width = 23.3, potentiometer_height = 4, box_height = 15, vertical_distance_to_potentiometer = 7, _stopper_shift = -0.9);
}
//---------------------------------------------------------------------------
module elbow_gear()
{// partial gear
    pot_gear(13, rb_626_external_radius, 10); 
}
//---------------------------------------------------------------------------
module foreram_motor_with_sheet()
{
    nema_11_with_27_1_gearbox();
    translate ([0, 0, nema_11_with_27_1_gearbox_height + 2]) mirror([0, 0, 1]) stepper_gearbox_nema_11_motor_platic_sheet();
}
//---------------------------------------------------------------------------

module elbow_pulley_with_components()
{
    // pulley 
    elbow_pulley();
    
    // belt tensioner bearings
    translate ([distance_to_fore_arm_gear - 3, -belt_hole_forearm_pulley / 2 - 2, 3]) rotate ([0, 90, 0]) {
        translate ([12, belt_hole_forearm_pulley / 2 + wall_thick_lateral_motor_housing - 15, -5]) belt_tensioner_slider();
        translate ([12, belt_hole_forearm_pulley / 2 + wall_thick_lateral_motor_housing + 15, -5]) belt_tensioner_slider();
    }
    
    // M6 screw
    translate([0, 0, 2 * rb_626_thick + 2 * washer_6_thick + elbow_gear_grip_sheet_size[2]]) mirror([0, 0, 1]) M6_sunken(30);
    // bearing
    626rs();
    //bearing
    translate([0, 0, rb_626_thick]) 626rs();
    // nut
    translate([0, 0, - (2 * washer_6_thick + m6_nut_thick + elbow_gear_grip_sheet_size[2])]) M6_nut();
    for (i = [0 : 1]){ // 2 washers on both sizes
      translate([0, 0, 2 * rb_626_thick + i * washer_6_thick]) washer_6_12();
      translate([0, 0, -(i + 1) * washer_6_thick]) washer_6_12();
    }
    // motor housing
    //translate ([distance_to_fore_arm_gear - 3, -belt_hole_forearm_pulley / 2 - 2, 0]) rotate ([0, 90, 0]) 
      //forearm_motor_housing_with_components();
    
    // stepper motor
    translate ([distance_to_fore_arm_gear - nema_11_with_27_1_gearbox_height - 2 - wall_thick_3, 0, -nema_11_width / 2 - 3 - 20]) 
    rotate ([0, 90, 0])
        foreram_motor_with_sheet();
    
    // motor pulley
    translate ([distance_to_fore_arm_gear + 1, 0, -nema_11_width / 2 - 3 - 20]) rotate ([0, 90, 0]) 
    motor_pulley_6mm_shaft();
    
    // belt
    translate ([20 + 3 + 3, 0, -nema_11_width / 2 - 3 - 15]) rotate ([0, -90, 0]) 
    belt_on_2_pulleys(8, 16, 82, 6);
    
    // potentiometer support
    //translate ([54.5, 24, 0]) rotate ([0, 90, 180]) forearm_potentiometer_support();
    
    // potentiometer
    translate ([55 - 7 - 2 - 2, 0, -10]) rotate ([0, 90, 0]) potentiometer_BOURNS_3852A_282_103AL();
    
        // bearing housing
    translate ([fore_arm_x_offset, 0, 0]) 
        rotate ([0, 0, 90]) {
            translate ([0, 0, pulley_T5_6mm_thick])rbearing_6905_vertical_double_housing_bounded_half_small_extra_height(fore_arm_z_offset);
            mirror([0, 0, 1])
                translate ([0, 0, -(pulley_T5_6mm_thick + f_rbearing_6905_vertical_double_housing_size_bounded_half_small(fore_arm_z_offset)[2] + f_rbearing_6905_vertical_double_housing_size_bounded_half_small(0)[2])]) rbearing_6905_vertical_double_housing_bounded_half_small_extra_height(0);
    }
    ;

}
//---------------------------------------------------------------------------
module forearm_bone()
{
    color ("black") cylinder_empty(fore_arm_length, forearm_shaft_radius, forearm_shaft_radius - 2);
}
//---------------------------------------------------------------------------
module gripper_c920_support_with_camera()
{
    gripper_c920_support();
    translate ([0, 0, c920_depth]) rotate ([90, 0, 0]) mirror ([0, 1, 0]) c920();
}
//---------------------------------------------------------------------------
module fore_arm()
{
// shaft
    translate ([0, 0, 0]) forearm_bone();
    // pulley
    forearm_pulley();
    
    // gripper motor
    translate([0, 0, -nema_14_39BYGL215A_height]) nema_14_39BYGL215A(290, -0 + 5);

    
// 6905 bearing
    translate ([0, 0, forearm_pulley_thick + 10 + 2]) 6905rs();
    translate ([0, 0, forearm_pulley_thick + 10 + 2 + rb_6905_thick]) 6905rs();

    // gripper
    translate([0, 0, fore_arm_length - gripper_motor_support_size[2]])
        rotate([0, 90, 0])
            translate ([-gripper_lateral_sheet_size[0], -gripper_lateral_sheet_size[1] / 2, -gripper_motor_support_size[0] / 2 -                    gripper_lateral_sheet_size[2]]) 
                            gripper();
    
// camera support
    translate ([-gripper_motor_support_size[0] / 2 - 16.5, c920_depth / 2 + c920_dist_between_holder_holes / 2, fore_arm_length - gripper_lateral_sheet_size[2] + (gripper_lateral_sheet_size[0] - gripper_distance_to_camera_support)]) rotate([0, 0, -90])  gripper_c920_support_with_camera();
}
//---------------------------------------------------------------------------
module fore_arm_with_elbow_pulley()
{
  translate ([18, 0, pulley_T5_6mm_thick + rb_6905_external_radius + fore_arm_z_offset + 4])
   rotate([angle_fore_arm, 0, 0]) 
    rotate ([0, 90, 0]) 
        rotate([0, 0, 90]) 
            fore_arm()
    ;
// elbow pulley
    elbow_pulley_with_components();
}
//---------------------------------------------------------------------------
module upper_arm_bone()
{
    difference(){
        color ("black") cylinder(h = upper_arm_bone_length, r = upper_arm_shaft_radius);
    }
}
//---------------------------------------------------------------------------
module elbow_gear_grip_sheet()
{
    difference(){
        color (aluminium_color) cube(elbow_gear_grip_sheet_size);
        for (i = [0 : 2])
            translate ([elbow_gear_grip_sheet_size[0] / 2, elbow_gear_grip_sheet_holes[i], 0] - display_tolerance_z) cylinder (h = elbow_gear_grip_sheet_size[2] + 2 * display_tolerance, r = elbow_gear_grip_sheet_holes_radius[i]);
    }
}
//---------------------------------------------------------------------------
module elbow_upper_arm_connector()
{
    // sheets
    translate([-elbow_sheet_size[0] / 2, -upper_arm_shaft_radius - tube_bracket_base_thick_strong,  0]) rotate([90, 0, 0]) elbow_sheet();
    translate([-elbow_sheet_size[0] / 2, upper_arm_shaft_radius + elbow_sheet_size[2] + tube_bracket_base_thick_strong, 0]) rotate([90, 0, 0]) elbow_sheet();
    
    // brakets
    translate([0, 0, + arm_bracket_thick / 2]) rotate([0, 90, 90]) tube_bracket_long_one_hole(bracket_thick = arm_bracket_thick, tube_radius = upper_arm_shaft_radius, half = true);
    translate([0, 0, + arm_bracket_thick / 2]) rotate([0, 90, -90]) tube_bracket_long_one_hole(bracket_thick = arm_bracket_thick, tube_radius = upper_arm_shaft_radius, half = true);

    translate([0, 0, - arm_bracket_thick / 2 + elbow_sheet_grip_length]) rotate([0, 90, 90]) tube_bracket_long_one_hole(bracket_thick = arm_bracket_thick, tube_radius = upper_arm_shaft_radius, half = true);
    translate([0, 0, - arm_bracket_thick / 2 + elbow_sheet_grip_length]) rotate([0, 90, -90]) tube_bracket_long_one_hole(bracket_thick = arm_bracket_thick, tube_radius = upper_arm_shaft_radius, half = true);
    
    // pulley grip sheet
    
    translate([-elbow_gear_grip_sheet_size[0] / 2, - distance_between_elbow_gear_grip_sheets / 2, elbow_sheet_size[1] - 20]) rotate([90, 0, 0]) elbow_gear_grip_sheet();
    translate([-elbow_gear_grip_sheet_size[0] / 2, elbow_sheet_size[2] + distance_between_elbow_gear_grip_sheets / 2, elbow_sheet_size[1] - 20]) rotate([90, 0, 0]) elbow_gear_grip_sheet();
    
    // belt tensioner bearings
    // screw first
    translate ([-(elbow_gear_grip_sheet_size[0] / 2 + wall_thick_2 + rb_624_external_radius), upper_arm_shaft_radius + tube_bracket_base_thick_strong + elbow_sheet_size[2] + m4_nut_thick, elbow_sheet_size[1] - 20]) rotate ([90, 0, 0]) {
        M4_hexa(50);
    
    // bearings
        translate ([0, 0, 23]) 624rs();
        translate ([0, 0, 18]) 624rs();
        translate ([0, 0, 28]) 624rs();
    }
    // second screw
    translate ([elbow_gear_grip_sheet_size[0] / 2 + wall_thick_2 + rb_624_external_radius, upper_arm_shaft_radius + tube_bracket_base_thick_strong + elbow_sheet_size[2] + m4_nut_thick, elbow_sheet_size[1] - 20]) rotate ([90, 0, 0]) {
        M4_hexa(50);
    // bearings
        translate ([0, 0, 23]) 624rs();
        translate ([0, 0, 18]) 624rs();
        translate ([0, 0, 28]) 624rs();
    }
    // screws for fixing the gripper sheets
    translate ([0, -8 + m4_nut_thick, elbow_sheet_size[1] - 5]) rotate ([90, 0, 0]) {
        M4_hexa(20);
    }
    translate ([0, -8 + m4_nut_thick, elbow_sheet_size[1] - 16]) rotate ([90, 0, 0]) {
        M4_hexa(20);
    }
    translate ([elbow_sheet_size[0]/ 2 - 10, -12, elbow_sheet_size[1] - 10]) rotate ([90, 0, 0]) potentiometer_BOURNS_3852A_282_103AL();
}
//---------------------------------------------------------------------------
module upper_arm_bone_with_components()
{
    // bone
    upper_arm_bone();
    translate ([0, 0, upper_arm_bone_length - elbow_sheet_grip_length]) elbow_upper_arm_connector();
}
//---------------------------------------------------------------------------
module belt_tensioner_elbow_pulley()
{
  belt_tensioner_with_branch(32);
}
//---------------------------------------------------------------------------
module upper_arm()
{
    // bone
   translate([0, 11, 0]) rotate ([90, 0, 0]) upper_arm_bone_with_components();
         
    // gear
    translate ([0, 9, 0]) rotate([0, 90, 0]) rotate ([90, 0, 0]) upper_arm_pulley(); 
    
    // stepper motor 
    translate ([0, sheet_upper_arm_motor_top_size[0] / 2 + 11 + 1, -nema_17_with_19_1_gearbox_height / 2]) 
    rotate([0, 0, 90])
    translate ([0, distance_upper_arm_motor_shaft, 0])
    upper_arm_motor_with_components()
    ;
    
    // forearm
    translate ([0, - upper_arm_bone_length - 60, -5.5])  
        rotate([0, 0, angle_elbow]) 
                fore_arm_with_elbow_pulley()
    ;
    
    // belt
    translate ([0, 9 + 3 + nema_17_width / 2, upper_arm_motor_housing_shift + 10]) rotate([0, 0, -90]) belt_on_2_pulleys(10, 52, upper_arm_bone_length + nema_17_width / 2 + 52, 5);
}
//---------------------------------------------------------------------------
module shoulder_motor_housing()
{
    nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset = 2 * shoulder_shaft_radius, belt_tensioner_offset = 0, nema_width = nema_17_width, nema_height = nema_17_height, base_height = 40,  nema_center_hole_radius = nema_17_gearbox_motor_hole_radius, nema_holes_position = gearbox_nema_17_holes_position, base_thick = 3, dist_to_first_hole_z = 18, nema_housing_base_holes = nema_17_housing_base_holes, sunken_base_holes = 0);
}
//---------------------------------------------------------------------------
module shoulder()
{
    //plate
    shoulder_plate();
    
    // motor
    translate ([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - nema_17_with_19_1_gearbox_height - wall_thick_base_motor_housing, -nema_17_width / 2 - 2 * shoulder_shaft_radius]) 
        rotate ([-90, 0, 0]) 
            nema_17_with_19_1_gearbox()
    ;
// motor gear for forearm  rotation
    translate ([shoulder_plate_size[0] / 2, (shoulder_plate_size[1] + 17), -nema_17_width / 2 - 2 * shoulder_shaft_radius]) 
    rotate ([90, 0, 0]) 
    motor_pulley_8mm_shaft();
    
    // motor housing
    translate ([shoulder_plate_size[0] / 2 + nema_17_housing_width / 2, shoulder_plate_size[1] , 0]) 
    mirror([0, 0, 1])
    rotate ([0, -90, 90])
    body_stepper_motor_housing_with_belt_tensioner();
    
    // bone support 1
    translate ([shoulder_plate_size[0] / 2, first_bearing_shoulder_offset + rbearing_6906_enclosed_housing_size[1] / 2, shoulder_plate_size[2] + rbearing_6906_enclosed_housing_size[2]])
      mirror([0, 0, 1])
        radial_bearing_6906_vertical_housing()
        ;      
        // potentiometer
        translate ([42 / 2 + shoulder_plate_size[0] / 2, 0, 0]) rotate([0, 90, 90]) potentiometer_support_squared_with_screw_holes(length = 25, width = 42, height = 13, dist_between_support_holes = 30, dist_to_support_holes = 5, stopper_shift = 0);
        
// bearing 1        
    translate ([shoulder_plate_size[0] / 2, rbearing_6906_enclosed_housing_size[1] / 2 + rb_6906_thick / 2 + first_bearing_shoulder_offset, shoulder_plate_size[2] + rb_6906_external_radius])
rotate([90, 0, 0])
        6906rs();
    
    // bone support 2
    translate ([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - rbearing_6906_enclosed_housing_size[1] / 2, shoulder_plate_size[2] + rbearing_6906_enclosed_housing_size[2]])
      mirror([0, 0, 1])
        radial_bearing_6906_vertical_housing();
        
        // bearing 2
    translate ([shoulder_plate_size[0] / 2, -rbearing_6906_enclosed_housing_size[1] / 2 + rb_6906_thick / 2 + shoulder_plate_size[1], shoulder_plate_size[2] + rb_6906_external_radius])
rotate([90, 0, 0])
        6906rs();
        
    // continuation with upper arm
    translate ([shoulder_plate_size[0]/ 2, shoulder_plate_size[1] + 7, rb_6906_external_radius + shoulder_plate_size[2]]) rotate ([0, angle_upper_arm, 0]) upper_arm();    
// brackets for shoulder shaft
    translate ([(shoulder_plate_size[0] - ceil(nema_17_width)) / 2 - shoulder_bracket_length, 0, -f_bracket_height_strong(shoulder_shaft_radius)]) tube_bracket_long_one_hole(bracket_length = shoulder_bracket_length, tube_radius = shoulder_shaft_radius);
    translate ([shoulder_plate_size[0] - (shoulder_plate_size[0] - ceil(nema_17_width)) / 2, 0, -f_bracket_height_strong(shoulder_shaft_radius)]) tube_bracket_long_one_hole(bracket_length = shoulder_bracket_length, tube_radius = shoulder_shaft_radius);
}
//---------------------------------------------------------------------------
module potentiometer_support_shoulder_vertical()
{
    potentiometer_support_squared_with_screw_holes(length = 25, width = 48, height = 14, dist_between_support_holes = 30, dist_to_support_holes = 6);
}
//---------------------------------------------------------------------------
module body_stepper_motor_housing()
{
      nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset = 4, belt_tensioner_offset = 20, nema_width = 41, nema_height = nema_17_height, base_height = 40, nema_center_hole_radius = 5, nema_holes_position = nema17_gearbox_tensioner_sheet_screw_hole_position, base_thick = wall_thick_base_motor_housing, dist_to_first_hole_z = 18, nema_housing_base_holes = nema_17_housing_base_holes, sunken_base_holes = 1, belt_tensioner_distance_between_holes = belt_tensioner_distance_between_holes, motor_play_x = 10);
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
module pot_gear_with_screw_hole_14t()
{
    _height = 8;
    
    _internal_radius = 3.3;
    
    difference(){
        rotate([0, 0, 13])
            pot_gear(num_teeth = 14, internal_radius = _internal_radius, height = _height); 
            
          // m3 screw hole
        translate ([0, 0, _height / 2]) rotate([0, 90, 0]) cylinder (h = 22, r = 1.4, $fn = 30);  
          // m3 nut hole
        hull(){
            translate ([_internal_radius + 2, 0, 0]) rotate([0, 90, 0]) cylinder (h = 2.5, r = m3_nut_radius, $fn = 6);  
            translate ([_internal_radius + 2, 0, _height]) rotate([0, 90, 0]) cylinder (h = 2.5, r = m3_nut_radius, $fn = 6);  
        }
    }
}
//---------------------------------------------------------------------------
module body_arm_motor_with_sheet()
{
    nema_17_with_19_1_gearbox();
    
    translate ([0, 0, nema_17_with_19_1_gearbox_height]) 
        stepper_gearbox_motor_alu_sheet(nema_17_gearbox_alu_sheet_size, gearbox_nema_17_holes_position, nema17_gearbox_tensioner_sheet_screw_hole_position, nema_17_gearbox_motor_hole_radius);
    
    // screws
    for (i = [1: 4])
        translate(nema17_gearbox_tensioner_sheet_screw_hole_position[i] + [0, 0, nema_17_with_19_1_gearbox_height]){
            translate([0, 0, -m4_nut_thick]) M4_hexa(12);
            translate([0, 0, 6]) washer_4_12();
        }
    
}
//---------------------------------------------------------------------------
module potentiometer_support_motor1()
{
    length = pot_92R1A_J22_L15L_base_width + 2 * wall_thick_2;
}
//---------------------------------------------------------------------------
module rbearing_6905_vertical_housing_bounded_half_small_bottom()
{
    difference(){
        rbearing_6905_vertical_housing_bounded_half_small_extra_height(extra_height_arm_bearing);
    }
}
//---------------------------------------------------------------------------
module body_articulation()
{
    // plate
    
    plate_body_articulation();
    // motor
    translate ([plate_body_size[0] / 2, -nema_17_with_19_1_gearbox_height + plate_body_size[1] - wall_thick_motor_housing - nema_17_gearbox_alu_sheet_size[2], -nema_17_width / 2 - wall_thick_base_motor_housing - 4 - 19]) rotate ([-90, 0, 0]) body_arm_motor_with_sheet();
    
    // motor gear
    translate ([plate_body_size[0] / 2, plate_body_size[1] + 4, -nema_17_width / 2 - wall_thick_base_motor_housing - 3 - 20]) rotate ([-90, 0, 0])motor_pulley_8mm_shaft();

// motor housing
    translate ([plate_body_size[0] / 2 - 41 / 2 - 2, plate_body_size[1], 0]) 
      rotate ([90, 0, 0]) 
        rotate ([0, 0, -90])
          body_stepper_motor_housing_with_belt_tensioner()
    ;
    
  translate ([plate_body_size[0] / 2, plate_body_size[1], plate_body_size[2] + 3])
    rotate([-90, 0, 0])  
        potentiometer_support_motor1();
    
    //support upper arm
    // first bearing housing
    
   translate ([plate_body_size[0] / 2, rbearing_6905_vertical_housing_size_bounded_half_small_bottom[1] / 2, rbearing_6905_enclosed_housing_size[2] + plate_body_size[2]])  
   mirror ([0, 0, 1]) 
    radial_bearing_6905_vertical_housing();
    ;
    
    // bearing
    translate ([plate_body_size[0] / 2, +rbearing_6905_vertical_housing_size_bounded_half_small_bottom[1] / 2 + rb_6905_thick / 2, plate_body_size[2] + rb_6905_external_radius])
        rotate([90, 0, 0]) 6905rs();
    
// second bearing housing
    
   translate ([plate_body_size[0] / 2, plate_body_size[1] - rbearing_6905_vertical_housing_size_bounded_half_small_bottom[1] / 2, rbearing_6905_enclosed_housing_size[2] + plate_body_size[2]])  
   mirror ([0, 0, 1]) 
    radial_bearing_6905_vertical_housing();

    // bearing
    translate ([plate_body_size[0] / 2, plate_body_size[1]  - rbearing_6905_vertical_housing_size_bounded_half_small_bottom[1] / 2 + rb_6905_thick / 2, plate_body_size[2] + rb_6905_external_radius])
        rotate([90, 0, 0]) 6905rs();
    
    // shaft
    translate ([plate_body_size[0] / 2, plate_body_size[1] + pulley_T5_6mm_thick + 4, rb_6905_external_radius + plate_body_size[2]]) 
      rotate ([0, angle_shoulder, 0]) 
        rotate ([90, 0, 0]) 
            color ("black") 
              cylinder_empty(upper_arm_shaft_support_length, shoulder_shaft_radius, shoulder_shaft_radius - 2)
              ;
    ;
    // pulley 
    translate ([plate_body_size[0] / 2, plate_body_size[1] + pulley_T5_6mm_thick + 4, rb_6905_external_radius + plate_body_size[2]])
      rotate ([90, 0, 0])
        rotate ([0, 0, -angle_shoulder])
          shoulder_traction_pulley();

    // upper arm
    translate ([0, -upper_arm_shaft_support_length + plate_body_size[1] + pulley_T5_6mm_thick + 4, rb_6905_external_radius])
      rotate ([0, angle_shoulder, 0])
        translate([offset_shoulder_plate_bracket, 0, body_shaft_radius + plate_body_size[2]])
          rotate ([0, 0, 90])
           shoulder() 
            ;
}
//---------------------------------------------------------------------------
module arm()
{    
    body_articulation();
}
//---------------------------------------------------------------------------
//arm();

body_articulation();

//shoulder();
//upper_arm();

//upper_arm_bone_with_components();

//elbow_upper_arm_connector();

//fore_arm();

//potentiometer_support_shoulder_vertical();

//motor_pulley_8mm_shaft(); //6x

//upper_arm_motor_with_components();

//nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(20, 5);

//nema_11_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 0);

//sholder_pulley();

//shoulder_motor_housing();


//forearm_pulley();
//motor_pulley_6mm_shaft(); // 2x


//fore_arm_with_elbow_pulley();

//forearm_motor_housing();

//elbow_pulley();

//elbow_pulley_with_components();

//upper_arm_pulley();
//upper_arm_motor_housing();
//upper_arm_pulley_with_components();

//plate_body_articulation();

//shoulder_plate();

//forearm_potentiometer_support();

//elbow_gear();

//radial_bearing_6905_vertical_housing_slim_double();

//rbearing_6905_vertical_housing_bounded_half_small();
//rbearing_6905_vertical_housing_bounded_half_small_top();

//body_arm_motor_with_sheet();

//body_stepper_motor_housing();

//body_stepper_motor_housing_with_belt_tensioner();

//pot_gear_with_screw_hole_14t();

//shoulder_traction_pulley(); // 1x

//elbow_potentiometer_support();

//gripper_c920_support_with_camera();

//body_arm_traction_pulley();

//radial_bearing_6905_vertical_housing(); // 2x

//radial_bearing_6906_vertical_housing(); // 2x

//upper_arm_motor_corners();

//tube_bracket_long_one_hole(bracket_length = shoulder_bracket_length, tube_radius = shoulder_shaft_radius);